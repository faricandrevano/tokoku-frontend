part of '../page.dart';

class _SummarySection extends StatelessWidget {
  const _SummarySection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, cart) {
        return Container(
          padding: const EdgeInsets.all(Dimens.dp16),
          decoration: BoxDecoration(
            color: context.theme.cardColor,
            borderRadius: BorderRadius.circular(Dimens.dp16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SubTitleText('Payment Summary'),
              _tile(
                context,
                item: '${cart.carts.length} Items',
                title: 'Product Quantity',
              ),
              _tile(context, item: cart.total.toIDR(), title: 'Product Price'),
              _tile(context, item: 'Free', title: 'Shipping'),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SubTitleText(
                    'Total',
                    style: TextStyle(color: context.theme.primaryColor),
                  ),
                  SubTitleText(
                    cart.total.toIDR(),
                    style: TextStyle(color: context.theme.primaryColor),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Padding _tile(
    BuildContext context, {
    required String title,
    required String item,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Dimens.dp8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RegularText(title),
          RegularText.mediumSolid(context, item),
        ],
      ),
    );
  }
}
