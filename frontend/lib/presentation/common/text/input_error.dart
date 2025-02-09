import 'package:flutter/material.dart';

class InputError extends StatelessWidget {
  final String text;

  const InputError(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 6),
      child: Text(text),
    );
  }
}
