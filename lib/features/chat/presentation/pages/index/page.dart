import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shamo_mobile/app/config.dart';
import 'package:shamo_mobile/core/core.dart';
import 'package:shamo_mobile/features/chat/chat.dart';
import 'package:shamo_mobile/features/home/home.dart';

part 'sections/empty_section.dart';
part 'sections/skeleton_section.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
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
    context.read<RoomBloc>().add(GetRoomsEvent(pageX));
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
    return BlocListener<CreateRoomBloc, CreateRoomState>(
      listener: (context, room) {
        if (room.status == CreateRoomStateStatus.success) {
          EasyLoading.dismiss();
          Navigator.pushNamed(
            context,
            DetailChatPage.routeName,
            arguments: room.room!.id,
          );
        } else if (room.status == CreateRoomStateStatus.failure) {
          EasyLoading.showError(
            room.failure?.message ?? 'Looks like something went wrong!',
          );
        } else if (room.status == CreateRoomStateStatus.loading) {
          EasyLoading.show(status: 'Loading...');
        }
      },
      child: BlocConsumer<RoomBloc, RoomState>(
        listener: (context, state) {
          if (state.status == RoomStateStatus.success) {
            page = state.page;
            totalPage = state.totalPage;
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(title: const Text('Message Support')),
            body: RefreshIndicator(
              onRefresh: () async {
                getList(1);
              },
              child: ListView(
                controller: controller,
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  if (state.status == RoomStateStatus.loading &&
                      state.rooms.isEmpty)
                    _SkeletonSection(key: widget.key)
                  else ...[
                    if (state.status == RoomStateStatus.success &&
                        state.rooms.isEmpty)
                      _EmptySection(key: widget.key)
                    else
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(Dimens.dp16),
                        itemBuilder: (context, index) => GestureDetector(
                          onTap: () {
                            context
                                .read<CreateRoomBloc>()
                                .add(ActionCreateRoomEvent(
                                  adminId: state.rooms[index].adminId,
                                ));
                          },
                          child: Row(
                            children: [
                              SmartNetworkImage(
                                state.rooms[index].admin.image ??
                                    AppConfig.profileUrl,
                                width: 54,
                                height: 54,
                                radius: BorderRadius.circular(Dimens.dp100),
                                fit: BoxFit.cover,
                              ),
                              Dimens.dp12.width,
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RegularText.mediumSolid(
                                      context,
                                      state.rooms[index].admin.name,
                                    ),
                                    RegularText(
                                      state.rooms[index].admin.email,
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                              Dimens.dp12.width,
                              RegularText(
                                state.rooms[index].updateAt.toFormattedString(),
                                style: const TextStyle(fontSize: 10),
                              ),
                            ],
                          ),
                        ),
                        separatorBuilder: (context, index) =>
                            const Divider(height: 32),
                        itemCount: state.rooms.length,
                      ),
                  ],
                  if (state.status == RoomStateStatus.isInfinite) ...[
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: Dimens.dp12),
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
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
