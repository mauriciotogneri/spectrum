import 'package:flutter/material.dart';

class LabelSmall extends StatelessWidget {
  final String text;

  const LabelSmall({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(text, style: const TextStyle(fontSize: 12));
  }
}
