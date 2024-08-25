import 'package:flutter/material.dart';
import 'package:shamo_mobile/core/core.dart';
import 'package:shimmer/shimmer.dart';

class SkeletonAnimation extends StatelessWidget {
  const SkeletonAnimation({
    Key? key,
    this.backgroundColor,
    this.width,
    this.height,
    this.radius,
    this.child,
    this.baseColor,
    this.highlightColor,
    this.borderRadius,
  }) : super(key: key);

  final Color? backgroundColor;
  final Color? baseColor;
  final Color? highlightColor;
  final double? width;
  final double? height;
  final double? radius;
  final BorderRadius? borderRadius;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor:
          baseColor ?? context.adaptiveTheme.solidTextColor!.withOpacity(.1),
      highlightColor: highlightColor ??
          context.adaptiveTheme.solidTextColor!.withOpacity(.2),
      child: child ??
          Container(
            width: width ?? double.infinity,
            height: height,
            decoration: BoxDecoration(
              color: backgroundColor ??
                  context.theme.disabledColor.withOpacity(.5),
              borderRadius: borderRadius ?? BorderRadius.circular(radius ?? 16),
            ),
          ),
    );
  }
}
