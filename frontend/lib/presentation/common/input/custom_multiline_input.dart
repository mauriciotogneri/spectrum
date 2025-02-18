import 'package:flutter/material.dart';
import 'package:testflow/presentation/common/input/custom_text_input.dart';

class CustomMultilineInput extends CustomTextInput {
  const CustomMultilineInput({
    required super.controller,
    required super.minLines,
    required super.maxLines,
    super.capitalization,
    super.enabled,
    super.autofocus,
    super.readOnly,
    super.filled,
    super.name,
    super.hint,
    super.autofillHints,
    super.prefixIcon,
    super.maxLength,
    super.width,
    super.errorMessage,
    super.onChanged,
    super.validator,
  }) : super(keyboardType: TextInputType.multiline);
}
