part of '../page.dart';

class _SkeletonSection extends StatelessWidget {
  const _SkeletonSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SkeletonAnimation(
      child: ListView.separated(
        shrinkWrap: true,
        padding: const EdgeInsets.all(Dimens.dp16),
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => Row(
          children: [
            const Skeleton(width: 54, height: 54, radius: 100),
            Dimens.dp12.width,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Skeleton(width: Dimens.dp150, height: Dimens.dp16),
                  Dimens.dp4.height,
                  const Skeleton(width: Dimens.dp100, height: Dimens.dp14),
                ],
              ),
            ),
            Dimens.dp12.width,
            const Skeleton(width: Dimens.dp32, height: Dimens.dp14),
          ],
        ),
        separatorBuilder: (context, index) => const Divider(height: 32),
        itemCount: 5,
      ),
    );
  }
}
