part of '../page.dart';

class _EmptySection extends StatelessWidget {
  const _EmptySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart_rounded,
            size: 100,
            color: context.theme.primaryColor,
          ),
          Dimens.dp8.height,
          const SubTitleText('Opss! Your Cart is Empty',
              align: TextAlign.center),
          Dimens.dp8.height,
          const RegularText(
            'Let\'s find your favorite shoes',
            align: TextAlign.center,
          ),
          Dimens.dp16.height,
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Explore Store'),
          ),
        ],
      ),
    );
  }
}
