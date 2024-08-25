import 'package:flutter/material.dart';
import 'package:shamo_mobile/core/core.dart';

class Skeleton extends StatelessWidget {
  const Skeleton({
    Key? key,
    this.backgroundColor,
    this.width,
    this.height,
    this.radius,
  }) : super(key: key);

  final Color? backgroundColor;
  final double? width;
  final double? height;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius ?? 4),
        color: backgroundColor ?? context.theme.disabledColor.withOpacity(.5),
      ),
    );
  }
}
