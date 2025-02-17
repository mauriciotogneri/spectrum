import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:testflow/presentation/common/form/form_input.dart';
import 'package:testflow/presentation/common/icon/input_icon.dart';
import 'package:testflow/presentation/common/input/custom_input.dart';
import 'package:testflow/utils/palette.dart';

class CustomTextInput extends StatefulWidget {
  final CustomTextInputController controller;
  final TextInputType keyboardType;
  final TextCapitalization capitalization;
  final TextInputAction? textInputAction;
  final bool enabled;
  final bool autofocus;
  final bool readOnly;
  final bool filled;
  final bool obscureText;
  final bool canClear;
  final String? name;
  final String? hint;
  final Iterable<String>? autofillHints;
  final IconData? prefixIcon;
  final int? maxLength;
  final int? minLines;
  final int? maxLines;
  final double? width;
  final String? errorMessage;
  final Function(String)? onChanged;
  final bool Function(String value)? validator;

  const CustomTextInput({
    required this.controller,
    this.keyboardType = TextInputType.none,
    this.capitalization = TextCapitalization.none,
    this.textInputAction,
    this.enabled = true,
    this.autofocus = false,
    this.readOnly = false,
    this.filled = true,
    this.obscureText = false,
    this.canClear = false,
    this.name,
    this.hint,
    this.autofillHints,
    this.prefixIcon,
    this.maxLength = 1000,
    this.minLines = 1,
    this.maxLines = 1,
    this.width,
    this.errorMessage,
    this.onChanged,
    this.validator,
  });

  @override
  State<CustomTextInput> createState() => _CustomTextInputState();
}

class _CustomTextInputState extends State<CustomTextInput> {
  bool showClear = false;

  @override
  Widget build(BuildContext context) {
    return FormInput(
      name: widget.name,
      errorMessage: widget.errorMessage,
      controller: widget.controller,
      builder:
          (hasError) => SizedBox(
            width: widget.width,
            height: 40,
            child: TextField(
              autofocus: widget.autofocus,
              minLines: widget.minLines,
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
              style: const TextStyle(
                color: Palette.textInput,
                fontSize: 14,
                overflow: TextOverflow.ellipsis,
              ),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(
                  top: 14,
                  left: 12,
                  right: widget.canClear ? 0 : 12,
                  bottom: 14,
                ),
                isDense: true,
                border:
                    hasError
                        ? CustomInput.errorBorder
                        : CustomInput.enabledBorder,
                enabledBorder:
                    hasError
                        ? CustomInput.errorBorder
                        : CustomInput.enabledBorder,

                disabledBorder:
                    hasError
                        ? CustomInput.errorBorder
                        : CustomInput.enabledBorder,

                focusedBorder:
                    hasError
                        ? CustomInput.errorBorder
                        : CustomInput.focusedBorder,
                errorBorder: CustomInput.errorBorder,
                focusedErrorBorder: CustomInput.errorBorder,

                prefixIcon: InputIcon.create(
                  widget.prefixIcon,
                  enabled: widget.enabled,
                ),
                suffixIcon: _suffixICon,
                filled: widget.filled,
                fillColor:
                    widget.enabled
                        ? Palette.backgroundInputEnabled
                        : Palette.backgroundInputDisabled,
                hoverColor: Palette.backgroundInputEnabled,
                hintText: widget.hint,
                hintStyle: const TextStyle(
                  color: Palette.textHint,
                  fontSize: 14,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              inputFormatters: [
                if (widget.maxLength != null)
                  LengthLimitingTextInputFormatter(widget.maxLength),
              ],
            ),
          ),
    );
  }

  Widget? get _suffixICon =>
      (widget.canClear && showClear) ? ClearIcon(_onClear) : null;

  void _onClear() {
    widget.controller.clear();
    widget.onChanged?.call('');
    setState(() {
      showClear = false;
    });
  }

  void _onChanged(String text) {
    widget.onChanged?.call(text);
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
      icon: const InputIcon(icon: Icons.close),
      onPressed: onPressed,
    );
  }
}

class CustomTextInputController extends CustomInputController<String> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  String get text => _controller.text.trim();

  @override
  String? get value => text;

  @override
  bool get isEmpty => value == null || value!.isEmpty;

  set text(String content) {
    _controller.text = content;
  }

  void clear() {
    _controller.text = '';
  }
}
