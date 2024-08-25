import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shamo_mobile/core/core.dart';
import 'package:shamo_mobile/features/transaction/transaction.dart';

part 'sections/empty_section.dart';
part 'sections/skeleton_section.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  static const String routeName = '/transaction';

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
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
    context.read<TransactionBloc>().add(GetTransactionEvent(pageX));
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
    return BlocConsumer<TransactionBloc, TransactionState>(
      listener: (context, state) {
        if (state.status == TransactionStateStatus.success) {
          page = state.page;
          totalPage = state.totalPage;
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: const Text('Your Orders')),
          body: ListView(
            controller: controller,
            children: [
              if (state.status == TransactionStateStatus.loading &&
                  state.transactions.isEmpty)
                _SkeletonSection(key: widget.key)
              else ...[
                if (state.status == TransactionStateStatus.success &&
                    state.transactions.isEmpty)
                  _EmptySection(key: widget.key)
                else
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(Dimens.dp16),
                    itemBuilder: (context, index) => Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Dimens.dp12,
                        vertical: Dimens.dp10,
                      ),
                      decoration: BoxDecoration(
                        color: context.theme.cardColor,
                        borderRadius: BorderRadius.circular(Dimens.dp12),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              SmartNetworkImage(
                                state.transactions[index].products.first.product
                                    .galleries.first,
                                width: 60,
                                height: 60,
                                radius: BorderRadius.circular(Dimens.dp12),
                                fit: BoxFit.cover,
                              ),
                              Dimens.dp12.width,
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SubTitleText(
                                      state.transactions[index].products
                                          .map((e) => e.product.name)
                                          .toList()
                                          .join(', '),
                                    ),
                                    RegularText.mediumSolid(
                                      context,
                                      state.transactions[index].total.toIDR(),
                                      style: TextStyle(
                                        color: context.theme.primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Dimens.dp8.height,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: Dimens.dp8,
                                  vertical: Dimens.dp2,
                                ),
                                decoration: BoxDecoration(
                                  color: context.theme.primaryColor,
                                  borderRadius:
                                      BorderRadius.circular(Dimens.dp50),
                                ),
                                child: RegularText.mediumSolid(
                                    context, state.transactions[index].status),
                              ),
                              RegularText(state.transactions[index].createdAt
                                  .toFormattedString()),
                            ],
                          ),
                        ],
                      ),
                    ),
                    separatorBuilder: (context, index) => Dimens.dp16.height,
                    itemCount: state.transactions.length,
                  ),
              ],
              if (state.status == TransactionStateStatus.isInfinite) ...[
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
        );
      },
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
