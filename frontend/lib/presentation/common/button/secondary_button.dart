import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class SecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool expanded;

  const SecondaryButton({
    required this.text,
    required this.onPressed,
    this.expanded = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: expanded ? double.infinity : null,
      child: ShadButton.outline(
        onPressed: onPressed,
        child: Text(text),
      ),
    );
  }
}
