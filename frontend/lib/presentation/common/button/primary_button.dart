import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool enabled;
  final bool expanded;

  const PrimaryButton({
    required this.text,
    this.onPressed,
    this.icon,
    this.enabled = true,
    this.expanded = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: expanded ? double.infinity : null,
      child: FilledButton(
        onPressed: enabled ? onPressed : null,
        child: Text(text),
      ),
    );
  }
}
