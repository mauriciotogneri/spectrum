import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class LabelSmall extends StatelessWidget {
  final String text;

  const LabelSmall({
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final ShadThemeData theme = ShadTheme.of(context);

    return Text(
      text,
      style: theme.textTheme.small.copyWith(
        color: theme.colorScheme.secondary,
      ),
    );
  }
}
