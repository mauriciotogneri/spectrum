import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:testflow/utils/palette.dart';

class TextInputField extends StatefulWidget {
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
  final String? hint;
  final Iterable<String>? autofillHints;
  final Widget? prefixIcon;
  final int? maxLength;
  final int? maxLines;
  final double? width;
  final Function(String)? onChange;
  final String? errorMessage;

  const TextInputField({
    required this.controller,
    this.keyboardType = TextInputType.none,
    this.textInputAction = TextInputAction.done,
    this.capitalization = TextCapitalization.none,
    this.enabled = true,
    this.autofocus = false,
    this.readOnly = false,
    this.filled = true,
    this.obscureText = false,
    this.canClear = false,
    this.hint,
    this.autofillHints,
    this.prefixIcon,
    this.maxLength,
    this.maxLines,
    this.width,
    this.onChange,
    this.errorMessage,
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
      child: TextFormField(
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
        onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          suffixIcon: _suffixICon,
          prefixIcon: widget.prefixIcon,
          filled: widget.filled,
          fillColor: Palette.background1,
          hintText: widget.hint,
        ),
        inputFormatters: [
          if (widget.maxLength != null)
            LengthLimitingTextInputFormatter(widget.maxLength),
        ],
      ),
    );
  }

  Widget? get _suffixICon =>
      (showClear && widget.canClear)
          ? IconButton(
            iconSize: 16,
            visualDensity: VisualDensity.compact,
            padding: EdgeInsets.zero,
            icon: const Icon(Icons.close, color: Palette.iconEnabled),
            onPressed: () {
              widget.controller.clear();
              widget.onChange?.call('');
              setState(() {
                showClear = false;
              });
            },
          )
          : null;

  void _onChanged(String text) {
    widget.onChange?.call(text);
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
    return Icon(icon, size: 16, color: Palette.iconEnabled);
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
