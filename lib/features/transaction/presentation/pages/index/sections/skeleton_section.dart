part of '../page.dart';

class _SkeletonSection extends StatelessWidget {
  const _SkeletonSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      padding: const EdgeInsets.all(Dimens.dp16),
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => Container(
        padding: const EdgeInsets.symmetric(
          horizontal: Dimens.dp12,
          vertical: Dimens.dp10,
        ),
        decoration: BoxDecoration(
          color: context.theme.cardColor,
          borderRadius: BorderRadius.circular(Dimens.dp12),
        ),
        child: SkeletonAnimation(
          child: Row(
            children: [
              const Skeleton(width: 60, height: 60, radius: Dimens.dp16),
              Dimens.dp12.width,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Skeleton(width: double.infinity, height: 18),
                    Dimens.dp4.height,
                    const Skeleton(width: Dimens.dp100, height: 14),
                  ],
                ),
              ),
              Dimens.dp12.width,
              const Skeleton(width: 14, height: 14, radius: 50)
            ],
          ),
        ),
      ),
      separatorBuilder: (context, index) => Dimens.dp16.height,
      itemCount: 5,
    );
  }
}
