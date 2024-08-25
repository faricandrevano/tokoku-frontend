part of '../page.dart';

class _ReceiverSection extends StatelessWidget {
  const _ReceiverSection({super.key, required this.chat});
  final Chat chat;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, theme) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: Dimens.dp16,
                vertical: Dimens.dp12,
              ),
              decoration: BoxDecoration(
                color: context.theme.dividerColor,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(Dimens.dp16),
                  bottomLeft: Radius.circular(Dimens.dp16),
                  bottomRight: Radius.circular(Dimens.dp16),
                ),
              ),
              child: RegularText(
                chat.message,
                style: TextStyle(
                    color: theme.theme == AppTheme.dark
                        ? null
                        : context.theme.scaffoldBackgroundColor),
              ),
            ),
          ],
        );
      },
    );
  }
}
