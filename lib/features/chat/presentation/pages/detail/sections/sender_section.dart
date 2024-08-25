part of '../page.dart';

class _SenderSection extends StatelessWidget {
  const _SenderSection({super.key, required this.chat});
  final Chat chat;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (chat.product != null)
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: Dimens.dp16,
              vertical: Dimens.dp12,
            ),
            margin: const EdgeInsets.only(bottom: Dimens.dp12),
            constraints: const BoxConstraints(
              maxHeight: 90,
              maxWidth: 230,
            ),
            decoration: BoxDecoration(
              color: context.theme.cardColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(Dimens.dp16),
                bottomLeft: Radius.circular(Dimens.dp16),
                bottomRight: Radius.circular(Dimens.dp16),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SmartNetworkImage(
                  chat.product!.galleries.first,
                  width: 65,
                  height: 65,
                  radius: BorderRadius.circular(Dimens.dp12),
                  fit: BoxFit.cover,
                ),
                Dimens.dp10.width,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RegularText(
                        chat.product!.name,
                        maxLine: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      RegularText(
                        chat.product!.price.toIDR(),
                        style: TextStyle(
                          color: context.adaptiveTheme.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: Dimens.dp16,
            vertical: Dimens.dp12,
          ),
          decoration: BoxDecoration(
            color: context.theme.cardColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(Dimens.dp16),
              bottomLeft: Radius.circular(Dimens.dp16),
              bottomRight: Radius.circular(Dimens.dp16),
            ),
          ),
          child: RegularText(chat.message),
        ),
      ],
    );
  }
}
