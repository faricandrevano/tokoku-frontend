import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shamo_mobile/app/config.dart';
import 'package:shamo_mobile/core/core.dart';
import 'package:shamo_mobile/features/chat/chat.dart';
import 'package:shamo_mobile/features/product/product.dart';
import 'package:shamo_mobile/features/settings/settings.dart';

part 'sections/heading_section.dart';
part 'sections/product_section.dart';
part 'sections/sender_section.dart';
part 'sections/receiver_section.dart';

class DetailChatPage extends StatefulWidget {
  const DetailChatPage({super.key, required this.id});
  final String id;

  static const String routeName = '/chat/detail';

  @override
  State<DetailChatPage> createState() => _DetailChatPageState();
}

class _DetailChatPageState extends State<DetailChatPage> {
  final TextEditingController messageController = TextEditingController();
  final ScrollController controller = ScrollController();
  int page = 0;
  int totalPage = 0;

  @override
  void initState() {
    getList(1);
    controller.addListener(onScroll);
    super.initState();
  }

  void getList(int pageX) {
    context.read<ChatBloc>().add(GetChatsEvent(page: pageX, roomId: widget.id));
  }

  void onScroll() {
    final maxScroll = controller.position.maxScrollExtent;
    final currentScroll = controller.position.pixels;
    if (currentScroll > maxScroll - 100 && page < totalPage) {
      getList(page + 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateRoomBloc, CreateRoomState>(
      builder: (context, room) {
        return BlocConsumer<ChatBloc, ChatState>(
          listener: (context, state) {
            if (state.statusMessage == ChatStateStatus.success) {
              messageController.clear();
              if (room.product != null) {
                context.read<CreateRoomBloc>().add(DeleteProductRoomEvent());
              }
            }
            if (state.status == ChatStateStatus.success) {
              page = state.page;
              totalPage = state.totalPage;
            }
          },
          builder: (context, state) {
            return Scaffold(
              body: Scaffold(
                appBar: AppBar(
                  title: _HeadingSection(
                    key: widget.key,
                    admin: room.room!.admin,
                  ),
                ),
                body: Stack(
                  children: [
                    RefreshIndicator(
                      onRefresh: () async {
                        getList(1);
                      },
                      child: ListView(
                        reverse: true,
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(Dimens.dp16),
                        children: [
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) =>
                                state.chats[index].type == 'USER'
                                    ? _SenderSection(
                                        key: widget.key,
                                        chat: state.chats[index],
                                      )
                                    : _ReceiverSection(
                                        key: widget.key,
                                        chat: state.chats[index],
                                      ),
                            separatorBuilder: (context, index) =>
                                Dimens.dp16.height,
                            itemCount: state.chats.length,
                          ),
                          if (state.status == ChatStateStatus.isInfinite) ...[
                            const Padding(
                              padding:
                                  EdgeInsets.symmetric(vertical: Dimens.dp12),
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: Dimens.dp20,
                                    height: Dimens.dp20,
                                    child: CircularProgressIndicator(),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    if (room.product != null)
                      ProductSection(
                        key: widget.key,
                        product: room.product!,
                      ),
                  ],
                ),
                bottomNavigationBar: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(Dimens.dp16),
                      child: Row(
                        children: [
                          Expanded(
                            child: RegularInput(
                              controller: messageController,
                              hintText: 'Type Message',
                              onChange: (v) {
                                setState(() {});
                              },
                            ),
                          ),
                          Dimens.dp8.width,
                          IconButton(
                            onPressed: messageController.text.isNotEmpty &&
                                    state.statusMessage !=
                                        ChatStateStatus.loading
                                ? () {
                                    FocusScope.of(context).unfocus();
                                    context.read<ChatBloc>().add(SendChatEvent(
                                          message: messageController.text,
                                          roomId: widget.id,
                                          productId: room.product?.id,
                                        ));
                                  }
                                : null,
                            icon: Icon(
                              Icons.send_rounded,
                              color: context.theme.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    messageController.dispose();
    controller.dispose();
    super.dispose();
  }
}
