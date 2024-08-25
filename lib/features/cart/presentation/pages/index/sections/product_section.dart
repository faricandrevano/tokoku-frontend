part of '../page.dart';

class _ProductSection extends StatelessWidget {
  const _ProductSection({super.key, required this.cart});
  final Cart cart;

  @override
  Widget build(BuildContext context) {
    return Row(
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
        Column(
          children: [
            _buildButton(context, isIncrement: true),
            Dimens.dp2.height,
            RegularText.mediumSolid(context, '${cart.qty}'),
            Dimens.dp2.height,
            _buildButton(context),
          ],
        ),
      ],
    );
  }

  Widget _buildButton(BuildContext context, {bool isIncrement = false}) {
    return InkWell(
      onTap: () {
        if (isIncrement) {
          context.read<CartBloc>().add(IncrementCartEvent(cart.id));
        } else {
          context.read<CartBloc>().add(DecrementCartEvent(cart.id));
        }
      },
      child: Container(
        padding: const EdgeInsets.all(Dimens.dp2),
        decoration: BoxDecoration(
          color: isIncrement
              ? context.theme.primaryColor
              : context.theme.scaffoldBackgroundColor,
          shape: BoxShape.circle,
        ),
        child: Icon(isIncrement ? Icons.add_rounded : Icons.remove, size: 16),
      ),
    );
  }
}
