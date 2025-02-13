import 'package:flutter/material.dart';
import 'package:testflow/utils/palette.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;

  const CustomCard({
    required this.child,
    this.width,
    this.padding,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Card(
        color: backgroundColor ?? Palette.background1,
        elevation: 0,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Palette.borderTable, width: 0.5),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: (padding != null) ? padding! : const EdgeInsets.all(0),
          child: child,
        ),
      ),
    );
  }
}
