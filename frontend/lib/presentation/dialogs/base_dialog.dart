import 'package:flutter/material.dart';

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

  static void show({required BuildContext context, required Widget dialog}) =>
      showDialog(
        barrierColor: const Color(0xeedddddd),
        context: context,
        builder: (context) => dialog,
      );

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Padding(
        padding: const EdgeInsets.only(left: 4),
        child: Text(title),
      ),
      actions: actions,
      insetPadding: const EdgeInsets.all(16),
      content: content,
    );
  }
}
