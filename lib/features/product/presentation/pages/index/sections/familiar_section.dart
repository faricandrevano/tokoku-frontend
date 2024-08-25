part of '../page.dart';

class _FamiliarSection extends StatelessWidget {
  const _FamiliarSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailProductBloc, DetailProductState>(
      builder: (context, state) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(Dimens.dp8),
          scrollDirection: Axis.horizontal,
          child: Row(
            children: (state.product?.galleries ?? []).map(
              (i) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Dimens.dp8),
                  child: SmartNetworkImage(
                    i,
                    width: 54,
                    height: 54,
                    fit: BoxFit.cover,
                    radius: BorderRadius.circular(Dimens.dp6),
                  ),
                );
              },
            ).toList(),
          ),
        );
      },
    );
  }
}
