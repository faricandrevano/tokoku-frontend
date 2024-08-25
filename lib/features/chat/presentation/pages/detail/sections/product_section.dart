part of '../page.dart';

class ProductSection extends StatelessWidget {
  const ProductSection({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: Container(
        margin: const EdgeInsets.all(Dimens.dp16),
        padding: const EdgeInsets.all(Dimens.dp10),
        constraints: const BoxConstraints(
          maxHeight: 74,
          maxWidth: 225,
        ),
        decoration: BoxDecoration(
          color: context.theme.scaffoldBackgroundColor,
          border: Border.all(color: context.theme.primaryColor),
          borderRadius: BorderRadius.circular(Dimens.dp16),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SmartNetworkImage(
              product.galleries.first,
              radius: BorderRadius.circular(Dimens.dp12),
              fit: BoxFit.cover,
            ),
            Dimens.dp10.width,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RegularText(
                    product.name,
                    maxLine: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  SubTitleText(
                    product.price.toIDR(),
                    style: TextStyle(color: context.adaptiveTheme.primaryColor),
                  ),
                ],
              ),
            ),
            Dimens.dp8.width,
            GestureDetector(
              onTap: () {
                context.read<CreateRoomBloc>().add(DeleteProductRoomEvent());
              },
              child: Icon(
                Icons.cancel_rounded,
                color: context.theme.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
