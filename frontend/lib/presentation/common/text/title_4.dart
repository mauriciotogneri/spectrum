import 'package:flutter/material.dart';

class Title4 extends StatelessWidget {
  final String text;

  const Title4({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text(text, style: const TextStyle(fontSize: 20)),
    );
  }
}
