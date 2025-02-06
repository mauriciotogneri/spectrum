import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextInput extends StatelessWidget {
  final String hint;
  final bool enabled;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final TextCapitalization capitalization;
  final bool autofocus;
  final bool readOnly;
  final bool filled;
  final bool showMaxLength;
  final bool obscureText;
  final EdgeInsetsGeometry? contentPadding;
  final Iterable<String>? autofillHints;
  final BorderRadius? borderRadius;
  final Color? fillColor;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final int? maxLength;
  final int? maxLines;
  final FocusNode? focusNode;
  final Function(String)? onChanged;
  final String? error;

  const TextInput({
    required this.hint,
    required this.controller,
    this.enabled = true,
    this.keyboardType = TextInputType.none,
    this.textInputAction = TextInputAction.done,
    this.capitalization = TextCapitalization.none,
    this.autofocus = false,
    this.readOnly = false,
    this.filled = false,
    this.showMaxLength = false,
    this.obscureText = false,
    this.contentPadding,
    this.autofillHints,
    this.borderRadius,
    this.fillColor,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLength,
    this.maxLines,
    this.focusNode,
    this.onChanged,
    this.error,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: autofocus,
      inputFormatters: [
        LengthLimitingTextInputFormatter(maxLength ?? 1000),
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
        contentPadding: contentPadding ?? const EdgeInsets.all(18),
        hintText: hint,
      ),
    );
  }
}
