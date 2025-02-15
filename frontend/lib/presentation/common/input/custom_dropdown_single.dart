import 'package:flutter/material.dart';
import 'package:testflow/utils/palette.dart';

class CustomDropdownSingle<T> extends StatelessWidget {
  final List<DropdownItem<T>> values;
  final String hint;
  final Widget? footer;
  final double? width;
  final bool allowDeselection;
  final bool enabled;
  final CustomDropdownSingleController<T>? controller;
  final Function(T)? onChange;
  final String? errorMessage;

  const CustomDropdownSingle({
    required this.values,
    required this.hint,
    this.controller,
    this.footer,
    this.width,
    this.onChange,
    this.errorMessage,
    this.allowDeselection = false,
    this.enabled = true,
  });

  void _onChanged(T? element) {
    controller?._focusNode.unfocus();

    if (element != null) {
      controller?.select(element);
      onChange?.call(element);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: DropdownMenu<T>(
        enableSearch: false,
        enabled: enabled,
        hintText: hint,
        label: Text(hint),
        initialSelection: controller?.selected,
        onSelected: _onChanged,
        dropdownMenuEntries: [
          for (final DropdownItem<T> item in values)
            DropdownMenuEntry(
              value: item.value,
              label: item.text,
              labelWidget: Text(
                item.text,
                style: const TextStyle(
                  color: Palette.textEnabled,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
        ],
        selectedTrailingIcon: const Icon(Icons.keyboard_arrow_up_rounded),
        trailingIcon: const Icon(Icons.keyboard_arrow_down_rounded),
        inputDecorationTheme: const InputDecorationTheme(
          contentPadding: EdgeInsets.all(18),
        ),
        menuStyle: MenuStyle(
          elevation: WidgetStateProperty.all(0),
          padding: WidgetStateProperty.all(const EdgeInsets.all(0)),
        ),
        expandedInsets: const EdgeInsets.all(0),
      ),
    );
  }
}

class DropdownItem<T> {
  final T value;
  final String text;
  final bool enabled;
  final Widget? icon;

  DropdownItem({
    required this.value,
    required this.text,
    this.enabled = true,
    this.icon,
  });

  factory DropdownItem.create(T value) =>
      DropdownItem(value: value, text: value.toString());

  @override
  bool operator ==(Object other) =>
      other is DropdownItem &&
      other.runtimeType == runtimeType &&
      other.value == value;

  @override
  int get hashCode => value.hashCode;
}

class CustomDropdownSingleController<T> {
  final FocusNode _focusNode = FocusNode();
  T? _selected;

  T? get selected => _selected;

  bool get isEmpty => _selected == null;

  bool get isNotEmpty => _selected != null;

  void close() {}

  void select(T value) {
    _selected = value;
  }
}
