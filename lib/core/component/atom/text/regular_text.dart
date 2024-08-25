import 'package:flutter/material.dart';
import 'package:shamo_mobile/core/core.dart';

class RegularText extends StatelessWidget {
  const RegularText(
    this.text, {
    Key? key,
    this.style,
    this.maxLine,
    this.overflow,
    this.align,
  }) : super(key: key);

  factory RegularText.normalSolid(
    BuildContext context,
    String text, {
    Key? key,
    TextStyle? style,
    int? maxLine,
    TextOverflow? overflow,
    TextAlign? align,
  }) {
    return RegularText(
      text,
      key: key,
      style: TextStyle(
        fontWeight: FontWeight.normal,
        color: context.adaptiveTheme.solidTextColor,
      ).merge(style),
      align: align,
      maxLine: maxLine,
      overflow: overflow,
    );
  }

  factory RegularText.mediumSolid(
    BuildContext context,
    String text, {
    Key? key,
    TextStyle? style,
    int? maxLine,
    TextOverflow? overflow,
    TextAlign? align,
  }) {
    return RegularText(
      text,
      key: key,
      style: TextStyle(
        fontWeight: FontWeight.w500,
        color: context.adaptiveTheme.solidTextColor,
      ).merge(style),
      align: align,
      maxLine: maxLine,
      overflow: overflow,
    );
  }

  factory RegularText.semiBoldSolid(
    BuildContext context,
    String text, {
    Key? key,
    TextStyle? style,
    int? maxLine,
    TextOverflow? overflow,
    TextAlign? align,
  }) {
    return RegularText(
      text,
      key: key,
      style: TextStyle(
        fontWeight: FontWeight.w600,
        color: context.adaptiveTheme.solidTextColor,
      ).merge(style),
      align: align,
      maxLine: maxLine,
      overflow: overflow,
    );
  }

  final String text;
  final TextStyle? style;
  final int? maxLine;
  final TextOverflow? overflow;
  final TextAlign? align;

  @override
  Widget build(BuildContext context) {
    final baseStyle = context.adaptiveTheme.regularTextStyle;

    return Text(
      text,
      style: baseStyle?.merge(style),
      maxLines: maxLine,
      overflow: overflow,
      textAlign: align,
    );
  }
}
