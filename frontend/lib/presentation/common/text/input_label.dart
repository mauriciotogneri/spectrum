import 'package:flutter/material.dart';
import 'package:testflow/presentation/common/text/custom_text.dart';
import 'package:testflow/utils/palette.dart';

class InputLabel extends StatelessWidget {
  final String text;

  const InputLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 4, left: 6),
      child: CustomText(
        text: text,
        size: 14,
        color: Palette.textTitle,
        weight: FontWeight.bold,
      ),
    );
  }
}
