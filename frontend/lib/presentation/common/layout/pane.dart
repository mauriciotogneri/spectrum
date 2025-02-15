import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:testflow/utils/navigation.dart';
import 'package:testflow/utils/palette.dart';

class Pane extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final Color backgroundColor;

  const Pane({
    required this.child,
    required this.padding,
    this.backgroundColor = Palette.background2,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      padding: padding,
      child: SizedBox.expand(child: child),
    );
  }

  factory Pane.normal({required Widget header, required Widget content}) =>
      Pane(
        padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [header, content],
        ),
      );

  factory Pane.withBack({required Widget header, required Widget content}) =>
      Pane(
        padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderWithBack(header),
            Padding(
              padding: const EdgeInsets.only(left: 6, right: 6),
              child: content,
            ),
          ],
        ),
      );
}

class HeaderWithBack extends StatelessWidget {
  final Widget child;

  const HeaderWithBack(this.child);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const IconButton(
          onPressed: Navigation.unstack,
          icon: Icon(Icons.keyboard_arrow_left_rounded),
        ),
        const HBox(4),
        child,
      ],
    );
  }
}
