import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

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
  final IconData? prefixIcon;
  final IconData? suffixIcon;
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
    /*return TextFormField(
      autofocus: autofocus,
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
      onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        filled: filled,
        labelText: hint,
      ),
      inputFormatters: [
        if (maxLength != null) LengthLimitingTextInputFormatter(maxLength),
      ],
    );*/
    return ShadInput(
      placeholder: Text(hint),
      autofocus: autofocus,
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
      onSubmitted: (_) => FocusScope.of(context).nextFocus(),
      prefix: (prefixIcon != null) ? TextInputIcon(prefixIcon!) : null,
      suffix: (suffixIcon != null) ? TextInputIcon(suffixIcon!) : null,
      inputFormatters: [
        if (maxLength != null) LengthLimitingTextInputFormatter(maxLength),
      ],
    );
  }
}

class TextInputIcon extends StatelessWidget {
  final IconData icon;

  const TextInputIcon(this.icon);

  @override
  Widget build(BuildContext context) {
    final ShadThemeData theme = ShadTheme.of(context);

    return Icon(
      icon,
      color: theme.colorScheme.mutedForeground,
    );
  }
}
