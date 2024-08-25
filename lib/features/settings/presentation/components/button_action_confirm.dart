import 'package:flutter/material.dart';
import 'package:shamo_mobile/core/core.dart';

class ButtonActionConfirm extends StatelessWidget {
  const ButtonActionConfirm({super.key, this.onCancel, this.onConfirm});

  final Function()? onCancel;
  final Function()? onConfirm;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: onCancel,
            child: RegularText.semiBoldSolid(
              context,
              'Cancel',
              style: TextStyle(color: context.theme.primaryColor),
            ),
          ),
        ),
        Dimens.dp14.width,
        Expanded(
          child: ElevatedButton(
            onPressed: onConfirm,
            child: RegularText.semiBoldSolid(
              context,
              'Yes',
              style: TextStyle(color: context.theme.canvasColor),
            ),
          ),
        ),
      ],
    );
  }
}
