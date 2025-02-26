import 'package:flutter/material.dart';
import 'package:testflow/utils/palette.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? borderSize;
  final double? cornerRadius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? backgroundColor;
  final Color? borderColor;
  final bool expand;

  const CustomCard({
    required this.child,
    this.width,
    this.borderSize,
    this.cornerRadius,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.borderColor,
    this.expand = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: expand ? double.infinity : width,
      child: Card(
        color: backgroundColor ?? Palette.backgroundEmpty,
        elevation: 0,
        margin: margin ?? EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: borderColor ?? Palette.borderCard,
            width: borderSize ?? 0.5,
          ),
          borderRadius: BorderRadius.circular(cornerRadius ?? 8),
        ),
        child: Padding(
          padding: padding ?? const EdgeInsets.all(16),
          child: child,
        ),
      ),
    );
  }
}
