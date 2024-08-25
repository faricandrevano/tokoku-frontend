part of '../page.dart';

class _HeadingSection extends StatelessWidget {
  const _HeadingSection({super.key, required this.admin});
  final Admin admin;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SmartNetworkImage(
          admin.image ?? AppConfig.profileUrl,
          width: 50,
          height: 50,
          radius: BorderRadius.circular(Dimens.dp100),
          fit: BoxFit.cover,
        ),
        Dimens.dp12.width,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SubTitleText(admin.name),
              RegularText(admin.email),
            ],
          ),
        ),
      ],
    );
  }
}
