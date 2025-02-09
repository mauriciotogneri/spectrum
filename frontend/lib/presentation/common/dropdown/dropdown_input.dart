import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:testflow/utils/palette.dart';

class DropdownInput<T> extends StatelessWidget {
  final List<T> values;
  final String hint;
  final DropdownInputController<T>? controller;
  final Widget? footer;
  final double? width;
  final bool allowDeselection;
  final bool isForm;
  final VoidCallback? onClear;
  final Function(T?)? onChangeSingle;
  final Function(List<T>)? onChangeMultiple;

  const DropdownInput({
    required this.values,
    this.hint = '',
    this.controller,
    this.footer,
    this.width,
    this.onChangeSingle,
    this.onChangeMultiple,
    this.onClear,
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
        controller: controller?._controller,
        initialValue: controller?.initialValue,
        selectedOptionBuilder: (context, value) => Text(value.toString()),
        allowDeselection: allowDeselection,
        onChanged: (element) {
          controller?._focusNode.unfocus();
          onChangeSingle?.call(element);
        },
        focusNode: controller?._focusNode,
        footer: footer,
        placeholder: Text(hint),
        options: _options,
      );

  ShadSelect<T> get _selectMultiple => ShadSelect<T>.multiple(
        controller: controller?._controller,
        initialValues: controller?.initialValues ?? [],
        selectedOptionsBuilder: (context, values) => Text(
          values.join(', '),
          style: const TextStyle(
            overflow: TextOverflow.ellipsis,
          ),
        ),
        allowDeselection: allowDeselection,
        onChanged: (element) {
          controller?._focusNode.unfocus();
          onChangeMultiple?.call(element);
        },
        focusNode: controller?._focusNode,
        footer: footer ?? ((onClear != null) ? _clearFooter : null),
        placeholder: Text(hint),
        options: _options,
      );

  ShadSelectFormField<T> get _selectSingleForm => ShadSelectFormField<T>(
        controller: controller?._controller,
        initialValue: controller?.initialValue,
        selectedOptionBuilder: (context, value) => Text(value.toString()),
        allowDeselection: allowDeselection,
        onChanged: (element) {
          controller?._focusNode.unfocus();
          onChangeSingle?.call(element);
        },
        focusNode: controller?._focusNode,
        footer: footer,
        placeholder: Text(hint),
        options: _options,
      );

  ShadSelectMultipleFormField<T> get _selectMultipleForm =>
      ShadSelectMultipleFormField(
        controller: controller?._controller,
        initialValue: controller?.initialValues ?? [],
        selectedOptionsBuilder: (context, values) => Text(
          values.join(', '),
          style: const TextStyle(
            overflow: TextOverflow.ellipsis,
          ),
        ),
        allowDeselection: allowDeselection,
        onChanged: (element) {
          controller?._focusNode.unfocus();
          onChangeMultiple?.call(element ?? []);
        },
        focusNode: controller?._focusNode,
        footer: footer ?? ((onClear != null) ? _clearFooter : null),
        placeholder: Text(hint),
        options: _options,
      );

  Widget get _clearFooter => Padding(
        padding: const EdgeInsets.only(bottom: 4),
        child: ShadButton.ghost(
          height: 32,
          padding: const EdgeInsets.only(
            left: 8,
          ),
          icon: const Icon(Icons.clear_rounded),
          mainAxisAlignment: MainAxisAlignment.start,
          onPressed: onClear,
          child: const Text('Clear'),
        ),
      );

  Widget get _dropdown {
    if (isForm) {
      return (onChangeMultiple != null) ? _selectMultipleForm : _selectSingleForm;
    } else {
      return (onChangeMultiple != null) ? _selectMultiple : _selectSingle;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: _dropdown,
    );
  }
}

class DropdownInputController<T> {
  final ShadPopoverController _controller = ShadPopoverController();
  final FocusNode _focusNode = FocusNode();
  final List<T> _selected = [];

  T? get initialValue => _selected.isNotEmpty ? _selected[0] : null;

  List<T> get initialValues => _selected;

  List<T> get selected => _selected;

  bool get isEmpty => _selected.isEmpty;

  bool get isNotEmpty => _selected.isNotEmpty;

  void close() => _controller.hide();

  void onChanged(List<T> value) {
    _selected.clear();
    _selected.addAll(value);
  }
}
