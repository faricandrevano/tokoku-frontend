part of '../page.dart';

class _SkeletonSection extends StatelessWidget {
  const _SkeletonSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(Dimens.dp16),
      itemBuilder: (context, index) => Container(
        padding: const EdgeInsets.symmetric(
          horizontal: Dimens.dp16,
          vertical: Dimens.dp10,
        ),
        decoration: BoxDecoration(
          color: context.theme.cardColor,
          borderRadius: BorderRadius.circular(Dimens.dp16),
        ),
        child: SkeletonAnimation(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Skeleton(width: 60, height: 60, radius: Dimens.dp16),
                  Dimens.dp12.width,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Skeleton(
                            width: double.infinity, height: Dimens.dp16),
                        Dimens.dp4.height,
                        const Skeleton(
                            width: Dimens.dp150, height: Dimens.dp14),
                      ],
                    ),
                  ),
                ],
              ),
              Dimens.dp12.height,
              const Skeleton(width: Dimens.dp100, height: Dimens.dp14),
            ],
          ),
        ),
      ),
      separatorBuilder: (context, index) => Dimens.dp16.height,
      itemCount: 3,
    );
  }
}
