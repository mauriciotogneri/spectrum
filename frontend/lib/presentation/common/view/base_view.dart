import 'package:flutter/material.dart';
import 'package:testflow/utils/palette.dart';

class BaseView extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;

  const BaseView({
    required this.child,
    required this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Palette.background1,
      padding: padding,
      child: child,
    );
  }
}
