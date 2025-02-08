import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:testflow/utils/palette.dart';

class DropdownInput<T> extends StatelessWidget {
  final List<T> values;
  final T? initialValue;
  final String? hint;
  final ShadPopoverController? controller;
  final FocusNode? focusNode;
  final Widget? footer;
  final double? width;
  final bool allowDeselection;
  final Function(T?)? onChange;

  const DropdownInput({
    required this.values,
    this.initialValue,
    this.hint,
    this.controller,
    this.focusNode,
    this.footer,
    this.width,
    this.onChange,
    this.allowDeselection = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ShadSelect<T>(
        controller: controller,
        initialValue: initialValue,
        selectedOptionBuilder: (context, value) => Text(value.toString()),
        allowDeselection: allowDeselection,
        onChanged: (element) {
          focusNode?.unfocus();
          onChange?.call(element);
        },
        focusNode: focusNode,
        footer: footer,
        placeholder: (hint != null) ? Text(hint!) : null,
        options: [
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
        ],
      ),
    );
  }
}
