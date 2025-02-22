import 'package:flutter/material.dart';
import 'package:testflow/presentation/common/layout/scrollable_column.dart';
import 'package:testflow/presentation/common/navigation/navigation_path.dart';
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

class PaneHeader extends StatelessWidget {
  final NavigationPath path;
  final List<Widget> actions;

  const PaneHeader({required this.path, required this.actions});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, left: 32, right: 32),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [path, const Spacer(), ...actions],
      ),
    );
  }
}
