import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:testflow/utils/palette.dart';

class CustomTextInput extends StatefulWidget {
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

  const CustomTextInput({
    required this.controller,
    this.keyboardType = TextInputType.none,
    this.textInputAction = TextInputAction.next,
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
    this.maxLength = 1000,
    this.maxLines = 1,
    this.width,
    this.onChange,
    this.errorMessage,
  });

  @override
  State<CustomTextInput> createState() => _CustomTextInputState();
}

class _CustomTextInputState extends State<CustomTextInput> {
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
        focusNode: widget.controller._focusNode,
        textInputAction: widget.textInputAction,
        controller: widget.controller._controller,
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
      (widget.canClear && showClear) ? ClearIcon(_onClear) : null;

  void _onClear() {
    widget.controller.clear();
    widget.onChange?.call('');
    setState(() {
      showClear = false;
    });
  }

  void _onChanged(String text) {
    widget.onChange?.call(text);
    setState(() {
      showClear = text.isNotEmpty;
    });
  }
}

class ClearIcon extends StatelessWidget {
  final VoidCallback onPressed;

  const ClearIcon(this.onPressed);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: 16,
      visualDensity: VisualDensity.compact,
      padding: EdgeInsets.zero,
      icon: const Icon(Icons.close, color: Palette.iconEnabled),
      onPressed: onPressed,
    );
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
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  String get text => _controller.text.trim();

  bool get isEmpty => text.isEmpty;

  bool get isNotEmpty => text.isNotEmpty;

  set text(String content) {
    _controller.text = content;
  }

  void clear() {
    _controller.text = '';
  }
}
