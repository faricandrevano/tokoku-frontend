part of '../page.dart';

class _ItemSection extends StatelessWidget {
  const _ItemSection({super.key, required this.carts});
  final List<Cart> carts;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SubTitleText('List Items'),
        Dimens.dp8.height,
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) => _buildCard(context, carts[index]),
          separatorBuilder: (context, index) => Dimens.dp8.height,
          itemCount: carts.length,
        ),
      ],
    );
  }

  Widget _buildCard(BuildContext context, Cart cart) {
    return Container(
      padding: const EdgeInsets.all(Dimens.dp16),
      decoration: BoxDecoration(
        color: context.theme.cardColor,
        borderRadius: BorderRadius.circular(Dimens.dp16),
      ),
      child: Row(
        children: [
          SmartNetworkImage(
            cart.product.galleries.first,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
            radius: BorderRadius.circular(Dimens.dp16),
          ),
          Dimens.dp12.width,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RegularText.mediumSolid(
                  context,
                  cart.product.name,
                  maxLine: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                RegularText(
                  cart.product.price.toIDR(),
                  style: TextStyle(color: context.theme.primaryColor),
                ),
              ],
            ),
          ),
          Dimens.dp8.width,
          RegularText('${cart.qty} Items'),
        ],
      ),
    );
  }
}
