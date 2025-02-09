import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:testflow/presentation/dialogs/base_dialog.dart';
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
  final bool isForm;
  final Iterable<String>? autofillHints;
  final Widget? prefixIcon;
  final int? maxLength;
  final int? maxLines;
  final double? width;
  final Function(String)? onChanged;
  final String? Function(String)? validator;

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
    this.isForm = false,
    this.autofillHints,
    this.prefixIcon,
    this.maxLength,
    this.maxLines,
    this.width,
    this.onChanged,
    this.validator,
  });

  @override
  State<TextInputField> createState() => _TextInputFieldState();
}

class _TextInputFieldState extends State<TextInputField> {
  bool showClear = false;

  @override
  Widget build(BuildContext context) {
    if (widget.isForm) {
      return SizedBox(
        width: widget.width,
        child: ShadInputFormField(
          placeholder: Text(widget.hint),
          error: DialogError.new,
          autofocus: widget.autofocus,
          maxLines: widget.maxLines,
          readOnly: widget.readOnly,
          enableInteractiveSelection: !widget.readOnly,
          enabled: widget.enabled,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          controller: widget.controller.controller,
          onChanged: _onChanged,
          validator: widget.validator,
          obscureText: widget.obscureText,
          autofillHints: widget.autofillHints,
          textCapitalization: widget.capitalization,
          onSubmitted: (_) => FocusScope.of(context).nextFocus(),
          prefix: widget.prefixIcon,
          suffix: _suffix,
          inputFormatters: _inputFormatters,
        ),
      );
    } else {
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
          onChanged: _onChanged,
          obscureText: widget.obscureText,
          autofillHints: widget.autofillHints,
          textCapitalization: widget.capitalization,
          onSubmitted: (_) => FocusScope.of(context).nextFocus(),
          prefix: widget.prefixIcon,
          suffix: _suffix,
          inputFormatters: _inputFormatters,
        ),
      );
    }
  }

  List<TextInputFormatter>? get _inputFormatters {
    if (widget.maxLength != null) {
      return [LengthLimitingTextInputFormatter(widget.maxLength)];
    } else {
      return null;
    }
  }

  Widget? get _suffix => (showClear && widget.canClear)
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
      : null;

  void _onChanged(String text) {
    widget.onChanged?.call(text);
    setState(() {
      showClear = text.isNotEmpty;
    });
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

  bool get isEmpty => text.isEmpty;

  bool get isNotEmpty => text.isNotEmpty;

  set text(String content) {
    controller.text = content;
  }

  void clear() {
    controller.text = '';
  }
}
