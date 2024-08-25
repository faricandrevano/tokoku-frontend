part of '../page.dart';

class _EmptySection extends StatelessWidget {
  const _EmptySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        (Dimens.height(context) / 5).height,
        Icon(
          CupertinoIcons.chat_bubble_2_fill,
          color: context.theme.primaryColor,
          size: 100,
        ),
        Dimens.dp8.height,
        const SubTitleText('Opss no message yet?', align: TextAlign.center),
        Dimens.dp8.height,
        const RegularText(
          'You have never done a transaction',
          align: TextAlign.center,
        ),
        Dimens.dp16.height,
        ElevatedButton(
          onPressed: () {
            context.read<BottomNavBloc>().add(const BottomNavChanged(0));
          },
          child: const Text('Explore Store'),
        ),
      ],
    );
  }
}
