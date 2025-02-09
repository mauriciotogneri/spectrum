import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:testflow/presentation/common/text/input_error.dart';
import 'package:testflow/utils/palette.dart';

class DropdownInputMultiple<T> extends StatelessWidget {
  final List<T> values;
  final String hint;
  final DropdownInputMultipleController<T>? controller;
  final Widget? footer;
  final double? width;
  final bool allowDeselection;
  final bool isForm;
  final Function(List<T>)? onChange;
  final String? errorMessage;

  const DropdownInputMultiple({
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

  ShadDecoration get _decoration =>
      const ShadDecoration(color: Palette.background1);

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

  ShadSelect<T> get _selectMultiple => ShadSelect<T>.multiple(
        minWidth: width,
        controller: controller?._controller,
        initialValues: controller?.selected ?? [],
        selectedOptionsBuilder: (context, values) => Text(
          values.join(', '),
          style: const TextStyle(
            overflow: TextOverflow.ellipsis,
          ),
        ),
        allowDeselection: allowDeselection,
        onChanged: _onChanged,
        focusNode: controller?._focusNode,
        footer: footer,
        decoration: _decoration,
        placeholder: Text(hint),
        options: _options,
      );

  ShadSelectMultipleFormField<T> get _selectMultipleForm =>
      ShadSelectMultipleFormField(
        minWidth: width,
        controller: controller?._controller,
        initialValue: controller?.selected ?? [],
        selectedOptionsBuilder: (context, values) => Text(
          values.join(', '),
          style: const TextStyle(
            overflow: TextOverflow.ellipsis,
          ),
        ),
        allowDeselection: allowDeselection,
        onChanged: _onChanged,
        focusNode: controller?._focusNode,
        validator: (value) => (value == null) ? errorMessage : null,
        error: InputError.new,
        footer: footer,
        decoration: _decoration,
        placeholder: Text(hint),
        options: _options,
      );

  void _onChanged(List<T>? elements) {
    controller?._focusNode.unfocus();

    if (elements != null) {
      controller?.select(elements);
      onChange?.call(elements);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: isForm ? _selectMultipleForm : _selectMultiple,
    );
  }
}

class DropdownInputMultipleController<T> {
  final ShadPopoverController _controller = ShadPopoverController();
  final FocusNode _focusNode = FocusNode();
  final List<T> _selected = [];

  List<T> get selected => _selected;

  bool get isEmpty => _selected.isEmpty;

  bool get isNotEmpty => _selected.isNotEmpty;

  void close() => _controller.hide();

  void select(List<T> value) {
    _selected.clear();
    _selected.addAll(value);
  }
}
