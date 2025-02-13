import 'package:flutter/material.dart';

class SecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool enabled;
  final bool expanded;

  const SecondaryButton({
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
      child: OutlinedButton(
        onPressed: enabled ? onPressed : null,
        child: Text(text),
      ),
    );
  }
}
