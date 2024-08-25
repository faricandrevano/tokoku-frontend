import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shamo_mobile/core/core.dart';
import 'package:shamo_mobile/features/favorite/favorite.dart';
import 'package:shamo_mobile/features/home/home.dart';
import 'package:shamo_mobile/features/product/product.dart';

part 'sections/skeleton_section.dart';
part 'sections/empty_section.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
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
    context.read<FavoriteBloc>().add(GetFavoriteEvent(pageX));
  }

  void onScroll() {
    final maxScroll = controller.position.maxScrollExtent;
    final currentScroll = controller.position.pixels;
    if (currentScroll > maxScroll - 200 && page < totalPage) {
      getList(page + 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavoriteBloc, FavoriteState>(
      listener: (context, state) {
        if (state.status == FavoriteStateStatus.success) {
          page = state.page;
          totalPage = state.totalPage;
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: const Text('Favorite Shoes')),
          body: ListView(
            controller: controller,
            padding: const EdgeInsets.all(Dimens.dp16),
            children: [
              if (state.status == FavoriteStateStatus.loading &&
                  state.favorites.isEmpty)
                _SkeletonSection(key: widget.key)
              else ...[
                if (state.status == FavoriteStateStatus.success &&
                    state.favorites.isEmpty)
                  _EmptySection(key: widget.key)
                else
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          ProductPage.routeName,
                          arguments: state.favorites[index].product.id,
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: Dimens.dp12,
                          vertical: Dimens.dp10,
                        ),
                        decoration: BoxDecoration(
                          color: context.theme.cardColor,
                          borderRadius: BorderRadius.circular(Dimens.dp12),
                        ),
                        child: Row(
                          children: [
                            SmartNetworkImage(
                              state.favorites[index].product.galleries.first,
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
                                    state.favorites[index].product.name,
                                    maxLine: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  RegularText(
                                    state.favorites[index].product.price
                                        .toIDR(),
                                    style: TextStyle(
                                        color: context.theme.primaryColor),
                                  ),
                                ],
                              ),
                            ),
                            Dimens.dp12.width,
                            InkWell(
                              onTap: () {
                                context.read<FavoriteBloc>().add(
                                      ActionFavoriteEvent(
                                          state.favorites[index].product.id),
                                    );
                              },
                              child: Container(
                                padding: const EdgeInsets.all(Dimens.dp8),
                                decoration: BoxDecoration(
                                  color: context.theme.primaryColor,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.favorite_rounded,
                                    size: 18),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    separatorBuilder: (context, index) => Dimens.dp16.height,
                    itemCount: state.favorites.length,
                  ),
              ],
              if (state.status == FavoriteStateStatus.isInfinite) ...[
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
