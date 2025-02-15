import 'package:flutter/material.dart';

class ScrollableColumn extends StatelessWidget {
  final List<Widget> children;

  const ScrollableColumn({required this.children});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: children,
        ),
      ),
    );
  }
}
