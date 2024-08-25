part of '../page.dart';

class _EmptySection extends StatelessWidget {
  const _EmptySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        (Dimens.height(context) / 5).height,
        Icon(
          Icons.shopping_cart_rounded,
          color: context.theme.primaryColor,
          size: 100,
        ),
        Dimens.dp8.height,
        const SubTitleText('You don\'t have transaction?',
            align: TextAlign.center),
        Dimens.dp8.height,
        const RegularText('Let\'s find your product shoes',
            align: TextAlign.center),
        Dimens.dp16.height,
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Explore Store'),
        ),
      ],
    );
  }
}
