import 'package:flutter/material.dart';
import 'package:testflow/presentation/common/icon/input_icon.dart';
import 'package:testflow/presentation/common/input/error_input_wrapper.dart';
import 'package:testflow/utils/palette.dart';

class CustomDropdownSingle<T> extends StatelessWidget {
  final CustomDropdownSingleController<T> controller;
  final List<DropdownItem<T>> values;
  final String hint;
  final IconData? icon;
  final double? width;
  final bool allowDeselection;
  final bool enabled;
  final Function(T)? onSelected;
  final String? errorMessage;

  const CustomDropdownSingle({
    required this.controller,
    required this.values,
    required this.hint,
    this.icon,
    this.width,
    this.onSelected,
    this.errorMessage,
    this.allowDeselection = false,
    this.enabled = true,
  });

  void _onSelected(T? element) {
    if (element != null) {
      controller._onSelected(
        value: element,
        allowDeselection: allowDeselection,
      );
      onSelected?.call(element);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormField<T>(
      validator: (_) {
        if (controller.selected == null) {
          return errorMessage;
        } else {
          return null;
        }
      },
      builder:
          (fieldState) => ErrorInputWrapper(
            error: fieldState.errorText,
            child: SizedBox(
              width: width,
              height: 40,
              child: Material(
                color: Palette.background1,
                borderRadius: const BorderRadius.all(Radius.circular(4)),
                child: InkWell(
                  onTap: () {},
                  overlayColor: WidgetStateProperty.all(
                    Palette.backgroundDropdownMenu,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                  child: DropdownMenu<T>(
                    width: width,
                    enableSearch: false,
                    enableFilter: false,
                    requestFocusOnTap: false,
                    enabled: enabled,
                    hintText: hint,
                    controller: controller._controller,
                    initialSelection: controller.selected,
                    onSelected: (element) {
                      FocusScope.of(context).unfocus();
                      _onSelected(element);
                    },
                    textStyle: const TextStyle(
                      color: Palette.textEnabled,
                      fontSize: 14,
                    ),
                    dropdownMenuEntries: [
                      for (final DropdownItem<T> item in values)
                        DropdownMenuEntry(
                          value: item.value,
                          label: item.text,
                          enabled: item.enabled,
                          leadingIcon: InputIcon.create(item.icon),
                          labelWidget: Text(
                            item.text,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Palette.textEnabled,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          trailingIcon:
                              item.value == controller.selected
                                  ? const InputIcon(icon: Icons.check)
                                  : null,
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(
                              Palette.backgroundDropdownMenu,
                            ),
                          ),
                        ),
                    ],
                    leadingIcon: InputIcon.create(icon),
                    trailingIcon: const InputIcon(
                      icon: Icons.keyboard_arrow_down_rounded,
                    ),
                    selectedTrailingIcon: const InputIcon(
                      icon: Icons.keyboard_arrow_up_rounded,
                    ),
                    inputDecorationTheme: InputDecorationTheme(
                      contentPadding: EdgeInsets.only(
                        left: (icon == null) ? 12 : 0,
                        right: 12,
                      ),
                      border:
                          (fieldState.errorText != null)
                              ? _errorBorder
                              : _enabledBorder,
                      enabledBorder:
                          (fieldState.errorText != null)
                              ? _errorBorder
                              : _enabledBorder,
                      disabledBorder:
                          (fieldState.errorText != null)
                              ? _errorBorder
                              : _enabledBorder,
                      focusedBorder:
                          (fieldState.errorText != null)
                              ? _errorBorder
                              : _focusedBorder,
                      errorBorder: _errorBorder,
                      focusedErrorBorder: _errorBorder,
                      hintStyle: const TextStyle(
                        fontSize: 14,
                        color: Palette.textHint,
                      ),
                    ),
                    menuStyle: MenuStyle(
                      elevation: WidgetStateProperty.all(0),
                      padding: WidgetStateProperty.all(const EdgeInsets.all(0)),
                    ),
                    expandedInsets: const EdgeInsets.all(0),
                  ),
                ),
              ),
            ),
          ),
    );
  }

  InputBorder get _enabledBorder => const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(4)),
    borderSide: BorderSide(color: Palette.borderInputEnabled, width: 0.5),
  );

  InputBorder get _focusedBorder => const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(4)),
    borderSide: BorderSide(color: Palette.borderInputFocused, width: 0.5),
  );

  InputBorder get _errorBorder => const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(4)),
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

  @override
  bool operator ==(Object other) =>
      other is DropdownItem &&
      other.runtimeType == runtimeType &&
      other.value == value;

  @override
  int get hashCode => value.hashCode;
}

class CustomDropdownSingleController<T> {
  final TextEditingController _controller = TextEditingController();
  T? _selected;

  T? get selected => _selected;

  bool get isEmpty => _selected == null;

  bool get isNotEmpty => _selected != null;

  void clear() {
    select(null);
  }

  void _onSelected({required T value, required bool allowDeselection}) {
    if (allowDeselection && (_selected == value)) {
      clear();
    } else {
      select(value);
    }
  }

  void select(T? value) {
    _selected = value;

    if (selected == null) {
      _controller.text = '';
    }
  }
}
