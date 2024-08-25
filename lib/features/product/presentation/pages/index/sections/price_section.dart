part of '../page.dart';

class _PriceSection extends StatelessWidget {
  const _PriceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailProductBloc, DetailProductState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.all(Dimens.dp16),
          decoration: BoxDecoration(
            color: context.theme.cardColor,
            borderRadius: BorderRadius.circular(Dimens.dp4),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const RegularText('Price starts from'),
              SubTitleText(
                (state.product?.price ?? 0).toIDR(),
                style: TextStyle(color: context.theme.primaryColor),
              ),
            ],
          ),
        );
      },
    );
  }
}
