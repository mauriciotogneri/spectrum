import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:testflow/presentation/dialogs/base_dialog.dart';
import 'package:testflow/utils/palette.dart';

class DropdownInputSingle<T> extends StatelessWidget {
  final List<T> values;
  final String hint;
  final DropdownInputSingleController<T>? controller;
  final Widget? footer;
  final double? width;
  final bool allowDeselection;
  final bool isForm;
  final Function(T)? onChange;
  final String? errorMessage;

  const DropdownInputSingle({
    required this.values,
    this.hint = '',
    this.controller,
    this.footer,
    this.width,
    this.onChange,
    this.errorMessage,
    this.allowDeselection = false,
    this.isForm = false,
  });

  List<Widget> get _options => [
        for (final T element in values)
          ShadOption(
            value: element,
            child: Text(element.toString()),
          ),
        if (footer != null) ...[
          const VBox(4),
          const HorizontalDivider(
            height: 0.2,
            color: Palette.divider,
          ),
        ],
      ];

  ShadSelect<T> get _selectSingle => ShadSelect<T>(
        minWidth: width,
        controller: controller?._controller,
        initialValue: controller?.selected,
        selectedOptionBuilder: (context, value) => Text(value.toString()),
        allowDeselection: allowDeselection,
        onChanged: _onChanged,
        focusNode: controller?._focusNode,
        footer: footer,
        placeholder: Text(hint),
        options: _options,
      );

  ShadSelectFormField<T> get _selectSingleForm => ShadSelectFormField<T>(
        minWidth: width,
        controller: controller?._controller,
        initialValue: controller?.selected,
        selectedOptionBuilder: (context, value) => Text(value.toString()),
        allowDeselection: allowDeselection,
        onChanged: _onChanged,
        focusNode: controller?._focusNode,
        validator: (value) => (value == null) ? errorMessage : null,
        error: DialogError.new,
        footer: footer,
        placeholder: Text(hint),
        options: _options,
      );

  void _onChanged(T? element) {
    controller?._focusNode.unfocus();

    if (element != null) {
      controller?.onChange(element);
      onChange?.call(element);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: isForm ? _selectSingleForm : _selectSingle,
    );
  }
}

class DropdownInputSingleController<T> {
  final ShadPopoverController _controller = ShadPopoverController();
  final FocusNode _focusNode = FocusNode();
  T? _selected;

  T? get selected => _selected;

  bool get isEmpty => _selected == null;

  bool get isNotEmpty => _selected != null;

  void close() => _controller.hide();

  void onChange(T value) {
    _selected = value;
  }
}
