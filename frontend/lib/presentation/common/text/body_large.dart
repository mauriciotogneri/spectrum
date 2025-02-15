import 'package:flutter/material.dart';
import 'package:testflow/presentation/common/text/custom_text.dart';
import 'package:testflow/utils/palette.dart';

class BodyLarge extends StatelessWidget {
  final String text;
  final TextAlign? align;
  final TextOverflow? overflow;
  final EdgeInsetsGeometry? padding;
  final Color? color;

  const BodyLarge({
    required this.text,
    this.align,
    this.overflow,
    this.padding,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return CustomText(
      text: text,
      size: 16,
      color: color ?? Palette.textBody,
      weight: FontWeight.normal,
      align: align,
      overflow: overflow,
      padding: padding,
    );
  }
}
