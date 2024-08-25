part of '../page.dart';

class _TitleSection extends StatelessWidget {
  const _TitleSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailProductBloc, DetailProductState>(
      builder: (context, state) {
        if (state.status == DetailProductStateStatus.success) {
          return Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SubTitleText(
                      state.product?.name ?? '',
                      style: const TextStyle(fontSize: 18),
                    ),
                    RegularText(state.product?.category.name ?? ''),
                  ],
                ),
              ),
              InkWell(
                borderRadius: BorderRadius.circular(Dimens.dp100),
                onTap: () {
                  context.read<DetailProductBloc>().add(
                        ActionFavoriteProductEvent(state.product!.id),
                      );
                },
                child: Container(
                  padding: const EdgeInsets.all(Dimens.dp8),
                  decoration: BoxDecoration(
                    color: state.isFavorite
                        ? context.theme.primaryColor
                        : context.theme.cardColor,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.favorite_rounded, size: 18),
                ),
              ),
            ],
          );
        } else {
          return SkeletonAnimation(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Skeleton(width: Dimens.dp200, height: Dimens.dp18),
                Dimens.dp4.height,
                const Skeleton(width: Dimens.dp100, height: Dimens.dp14),
              ],
            ),
          );
        }
      },
    );
  }
}
