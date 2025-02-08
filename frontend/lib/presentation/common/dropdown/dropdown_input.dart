import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:testflow/utils/palette.dart';

class DropdownInput<T> extends StatelessWidget {
  final List<T> values;
  final T? initialValue;
  final List<T>? initialValues;
  final String? hint;
  final ShadPopoverController? controller;
  final FocusNode? focusNode;
  final Widget? footer;
  final double? width;
  final bool allowDeselection;
  final Function(T?)? onChangeSingle;
  final Function(List<T>)? onChangeMultiple;

  const DropdownInput({
    required this.values,
    this.initialValue,
    this.initialValues,
    this.hint,
    this.controller,
    this.focusNode,
    this.footer,
    this.width,
    this.onChangeSingle,
    this.onChangeMultiple,
    this.allowDeselection = false,
  });

  List<Widget> get options => [
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

  ShadSelect<T> get selectSingle => ShadSelect<T>(
        controller: controller,
        initialValue: initialValue,
        selectedOptionBuilder: (context, value) => Text(value.toString()),
        allowDeselection: allowDeselection,
        onChanged: (element) {
          focusNode?.unfocus();
          onChangeSingle?.call(element);
        },
        focusNode: focusNode,
        footer: footer,
        placeholder: (hint != null) ? Text(hint!) : null,
        options: options,
      );

  ShadSelect<T> get selectMultiple => ShadSelect<T>.multiple(
        controller: controller,
        initialValues: initialValues ?? [],
        selectedOptionsBuilder: (context, values) => Text(
          values.join(', '),
          style: const TextStyle(
            overflow: TextOverflow.ellipsis,
          ),
        ),
        allowDeselection: allowDeselection,
        onChanged: (element) {
          focusNode?.unfocus();
          onChangeMultiple?.call(element);
        },
        focusNode: focusNode,
        footer: footer,
        placeholder: (hint != null) ? Text(hint!) : null,
        options: options,
      );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: (onChangeMultiple != null) ? selectMultiple : selectSingle,
    );
  }
}
