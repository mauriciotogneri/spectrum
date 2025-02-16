import 'package:flutter/material.dart';
import 'package:testflow/utils/style.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double? size;
  final Color? color;
  final FontWeight? weight;
  final TextAlign? align;
  final TextOverflow? overflow;
  final EdgeInsetsGeometry? padding;

  const CustomText({
    required this.text,
    this.size,
    this.color,
    this.weight,
    this.align,
    this.overflow,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Text(
        text,
        textAlign: align,
        overflow: overflow,
        style: Style.textStyle(color: color, size: size, weight: weight),
      ),
    );
  }
}
