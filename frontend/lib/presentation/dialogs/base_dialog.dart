import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:testflow/utils/palette.dart';

class BaseDialog extends StatelessWidget {
  final String title;
  final double width;
  final Widget content;
  final List<Widget> actions;

  const BaseDialog({
    required this.title,
    required this.width,
    required this.content,
    required this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return ShadDialog(
      title: Padding(
        padding: const EdgeInsets.only(left: 4),
        child: Text(title),
      ),
      padding: const EdgeInsets.all(16),
      closeIconPosition: const ShadPosition(
        top: 16,
        right: 16,
      ),
      actions: actions,
      child: SizedBox(
        width: width,
        child: content,
      ),
    );
  }
}

class DialogLabel extends StatelessWidget {
  final String text;

  const DialogLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 6),
      child: Text(
        text,
        style: const TextStyle(
          color: Palette.textEnabled,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class DialogError extends StatelessWidget {
  final String text;

  const DialogError(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 6),
      child: Text(text),
    );
  }
}
