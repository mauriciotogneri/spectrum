import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:testflow/utils/palette.dart';

class CustomInput {
  static const double HEIGHT = 35;

  static InputBorder get enabledBorder => OutlineInputBorder(
    borderRadius: borderRadius,
    borderSide: const BorderSide(color: Palette.borderInputEnabled, width: 1),
  );

  static InputBorder get focusedBorder => OutlineInputBorder(
    borderRadius: borderRadius,
    borderSide: const BorderSide(color: Palette.borderInputFocused, width: 1),
  );

  static InputBorder get errorBorder => OutlineInputBorder(
    borderRadius: borderRadius,
    borderSide: const BorderSide(color: Palette.borderInputError, width: 1),
  );

  static BorderRadius get borderRadius => BorderRadius.circular(4);
}

abstract class CustomInputController<T> extends BaseState {
  T? get value;

  bool get isEmpty;

  bool get isNotEmpty => !isEmpty;
}
