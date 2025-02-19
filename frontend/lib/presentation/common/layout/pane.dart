import 'package:flutter/material.dart';
import 'package:testflow/presentation/common/layout/scrollable_column.dart';
import 'package:testflow/utils/palette.dart';

class Pane extends StatelessWidget {
  final Widget child;
  final Color backgroundColor;

  const Pane({
    required this.child,
    this.backgroundColor = Palette.backgroundPane,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: SizedBox.expand(child: child),
    );
  }

  factory Pane.scrollable({required List<Widget> children}) =>
      Pane(child: ScrollableColumn(children: children));
}
