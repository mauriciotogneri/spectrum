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
  final Function(T)? onSelected;
  final String? errorMessage;

  const CustomDropdownSingle({
    required this.values,
    required this.hint,
    this.controller,
    this.footer,
    this.width,
    this.onSelected,
    this.errorMessage,
    this.allowDeselection = false,
    this.enabled = true,
  });

  void _onSelected(T? element) {
    controller?._focusNode.unfocus();

    if (element != null) {
      controller?.select(element);
      onSelected?.call(element);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: DropdownMenu<T>(
        width: width,
        enableSearch: false,
        enableFilter: false,
        enabled: enabled,
        hintText: hint,
        initialSelection: controller?.selected,
        onSelected: _onSelected,
        focusNode: controller?._focusNode,
        dropdownMenuEntries: [
          for (final DropdownItem<T> item in values)
            DropdownMenuEntry(
              value: item.value,
              label: item.text,
              enabled: item.enabled,
              leadingIcon: item.iconWidget,
              labelWidget: Text(
                item.text,
                style: const TextStyle(
                  color: Palette.textEnabled,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(
                  const Color(0xfff8f8f8),
                ),
              ),
            ),
        ],
        selectedTrailingIcon: const Icon(Icons.keyboard_arrow_up_rounded),
        trailingIcon: const Icon(Icons.keyboard_arrow_down_rounded),
        inputDecorationTheme: InputDecorationTheme(
          contentPadding: const EdgeInsets.all(16),
          border: _enabledBorder,
          enabledBorder: _enabledBorder,
          disabledBorder: _enabledBorder,
          focusedBorder: _focusedBorder,
          errorBorder: _errorBorder,
          focusedErrorBorder: _errorBorder,
        ),
        menuStyle: MenuStyle(
          elevation: WidgetStateProperty.all(0),
          padding: WidgetStateProperty.all(const EdgeInsets.all(0)),
        ),
        expandedInsets: const EdgeInsets.all(0),
      ),
    );
  }

  InputBorder get _enabledBorder => const OutlineInputBorder(
    borderSide: BorderSide(color: Palette.borderInputEnabled, width: 0.5),
  );

  InputBorder get _focusedBorder => const OutlineInputBorder(
    borderSide: BorderSide(color: Palette.borderInputFocused, width: 0.5),
  );

  InputBorder get _errorBorder => const OutlineInputBorder(
    borderSide: BorderSide(color: Palette.borderInputError, width: 0.5),
  );
}

class DropdownItem<T> {
  final T value;
  final String text;
  final bool enabled;
  final IconData? icon;

  DropdownItem({
    required this.value,
    required this.text,
    this.enabled = true,
    this.icon,
  });

  factory DropdownItem.create(T value) =>
      DropdownItem(value: value, text: value.toString());

  Widget? get iconWidget =>
      icon != null ? Icon(icon, size: 20, color: Palette.iconEnabled) : null;

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

  void clear() {
    _selected = null;
  }

  void select(T value) {
    _selected = value;
  }
}
