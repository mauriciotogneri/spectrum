import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextInputField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final TextCapitalization capitalization;
  final bool enabled;
  final bool autofocus;
  final bool readOnly;
  final bool filled;
  final bool obscureText;
  final Iterable<String>? autofillHints;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final int? maxLength;
  final int? maxLines;
  final FocusNode? focusNode;
  final Function(String)? onChanged;

  const TextInputField({
    required this.hint,
    required this.controller,
    this.keyboardType = TextInputType.none,
    this.textInputAction = TextInputAction.done,
    this.capitalization = TextCapitalization.none,
    this.enabled = true,
    this.autofocus = false,
    this.readOnly = false,
    this.filled = false,
    this.obscureText = false,
    this.autofillHints,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLength,
    this.maxLines,
    this.focusNode,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: autofocus,
      inputFormatters: [
        if (maxLength != null) LengthLimitingTextInputFormatter(maxLength),
      ],
      maxLines: maxLines,
      readOnly: readOnly,
      enableInteractiveSelection: !readOnly,
      enabled: enabled,
      keyboardType: keyboardType,
      focusNode: focusNode,
      textInputAction: textInputAction,
      controller: controller,
      onChanged: onChanged,
      obscureText: obscureText,
      autofillHints: autofillHints,
      textCapitalization: capitalization,
      onFieldSubmitted: (s) => FocusScope.of(context).nextFocus(),
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        filled: filled,
        hintText: hint,
      ),
    );
  }
}
