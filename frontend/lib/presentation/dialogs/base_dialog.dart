import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

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

  static void show({
    required BuildContext context,
    required Widget dialog,
  }) =>
      showShadDialog(
        barrierColor: const Color(0xeedddddd),
        context: context,
        builder: (context) => dialog,
      );

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
