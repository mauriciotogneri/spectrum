import 'package:flutter/material.dart';
import 'package:testflow/utils/palette.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final bool expand;

  const CustomCard({
    required this.child,
    this.width,
    this.padding,
    this.backgroundColor,
    this.expand = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: expand ? double.infinity : width,
      child: Card(
        color: backgroundColor ?? Palette.background1,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Palette.borderCard, width: 0.5),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: padding ?? const EdgeInsets.all(16),
          child: child,
        ),
      ),
    );
  }
}
