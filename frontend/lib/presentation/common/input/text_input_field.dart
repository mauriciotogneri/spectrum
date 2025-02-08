import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:testflow/utils/palette.dart';

class TextInputField extends StatefulWidget {
  final String hint;
  final TextInputController controller;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final TextCapitalization capitalization;
  final bool enabled;
  final bool autofocus;
  final bool readOnly;
  final bool filled;
  final bool obscureText;
  final bool canClear;
  final Iterable<String>? autofillHints;
  final Widget? prefixIcon;
  final int? maxLength;
  final int? maxLines;
  final double? width;
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
    this.canClear = false,
    this.autofillHints,
    this.prefixIcon,
    this.maxLength,
    this.maxLines,
    this.width,
    this.onChanged,
  });

  @override
  State<TextInputField> createState() => _TextInputFieldState();
}

class _TextInputFieldState extends State<TextInputField> {
  bool showClear = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: ShadInput(
        placeholder: Text(widget.hint),
        autofocus: widget.autofocus,
        maxLines: widget.maxLines,
        readOnly: widget.readOnly,
        enableInteractiveSelection: !widget.readOnly,
        enabled: widget.enabled,
        keyboardType: widget.keyboardType,
        focusNode: widget.controller.focusNode,
        textInputAction: widget.textInputAction,
        controller: widget.controller.controller,
        onChanged: (text) {
          widget.onChanged?.call(text);
          setState(() {
            showClear = text.isNotEmpty;
          });
        },
        obscureText: widget.obscureText,
        autofillHints: widget.autofillHints,
        textCapitalization: widget.capitalization,
        onSubmitted: (_) => FocusScope.of(context).nextFocus(),
        prefix: widget.prefixIcon,
        suffix: (showClear && widget.canClear)
            ? ShadButton.ghost(
                width: 20,
                height: 20,
                padding: EdgeInsets.zero,
                decoration: const ShadDecoration(
                  secondaryBorder: ShadBorder.none,
                  secondaryFocusedBorder: ShadBorder.none,
                ),
                icon: const Icon(
                  Icons.close,
                  color: Palette.iconEnabled,
                ),
                onPressed: () {
                  widget.controller.clear();
                  widget.onChanged?.call('');
                  setState(() {
                    showClear = false;
                  });
                })
            : null,
        inputFormatters: [
          if (widget.maxLength != null)
            LengthLimitingTextInputFormatter(widget.maxLength),
        ],
      ),
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

class TextInputController {
  final TextEditingController controller = TextEditingController();
  final FocusNode focusNode = FocusNode();

  String get text => controller.text.trim();

  set text(String content) {
    controller.text = content;
  }

  void clear() {
    controller.text = '';
  }
}
