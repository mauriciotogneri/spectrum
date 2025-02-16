import 'package:flutter/material.dart';
import 'package:testflow/presentation/common/form/error_input_wrapper.dart';
import 'package:testflow/presentation/common/icon/input_icon.dart';
import 'package:testflow/presentation/common/input/custom_input.dart';
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
                color: Palette.backgroundEmpty,
                borderRadius: CustomInput.borderRadius,
                child: InkWell(
                  onTap: () {},
                  overlayColor: WidgetStateProperty.all(
                    Palette.backgroundEmpty,
                  ),
                  borderRadius: CustomInput.borderRadius,
                  child: LayoutBuilder(
                    builder:
                        (context, constraints) => DropdownMenu<T>(
                          width: constraints.maxWidth + 8,
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
                            color: Palette.textInput,
                            fontSize: 14,
                            overflow: TextOverflow.ellipsis,
                          ),
                          dropdownMenuEntries: [
                            for (final DropdownItem<T> item in values)
                              DropdownMenuEntry(
                                value: item.value,
                                label: item.text,
                                enabled: item.enabled,
                                leadingIcon: InputIcon.create(item.icon),
                                trailingIcon:
                                    item.value == controller.selected
                                        ? const InputIcon(icon: Icons.check)
                                        : null,
                                style: ButtonStyle(
                                  foregroundColor:
                                      item.enabled
                                          ? WidgetStateProperty.all(
                                            Palette.textInput,
                                          )
                                          : null,
                                  backgroundColor: WidgetStateProperty.all(
                                    item.enabled
                                        ? Palette.backgroundEmpty
                                        : Palette.backgroundInputDisabled,
                                  ),
                                ),
                              ),
                          ],
                          leadingIcon: InputIcon.create(icon),
                          trailingIcon: const InputIcon(
                            icon: Icons.keyboard_arrow_down_rounded,
                            size: 18,
                          ),
                          selectedTrailingIcon: const InputIcon(
                            icon: Icons.keyboard_arrow_up_rounded,
                            size: 18,
                          ),
                          inputDecorationTheme: InputDecorationTheme(
                            contentPadding: EdgeInsets.only(
                              left: (icon == null) ? 12 : 0,
                              right: 12,
                            ),
                            border:
                                (fieldState.errorText != null)
                                    ? CustomInput.errorBorder
                                    : CustomInput.enabledBorder,
                            enabledBorder:
                                (fieldState.errorText != null)
                                    ? CustomInput.errorBorder
                                    : CustomInput.enabledBorder,
                            disabledBorder:
                                (fieldState.errorText != null)
                                    ? CustomInput.errorBorder
                                    : CustomInput.enabledBorder,
                            focusedBorder:
                                (fieldState.errorText != null)
                                    ? CustomInput.errorBorder
                                    : CustomInput.focusedBorder,
                            errorBorder: CustomInput.errorBorder,
                            focusedErrorBorder: CustomInput.errorBorder,
                            hintStyle: const TextStyle(
                              color: Palette.textHint,
                              fontSize: 14,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          menuStyle: MenuStyle(
                            elevation: WidgetStateProperty.all(0),
                            padding: WidgetStateProperty.all(
                              const EdgeInsets.all(0),
                            ),
                            side: WidgetStateProperty.all(
                              const BorderSide(
                                color: Palette.borderInputEnabled,
                                width: 1,
                              ),
                            ),
                            shape: WidgetStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0),
                              ),
                            ),
                          ),
                          expandedInsets: const EdgeInsets.all(0),
                        ),
                  ),
                ),
              ),
            ),
          ),
    );
  }
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

  factory DropdownItem.create(T value, [bool enabled = true]) =>
      DropdownItem(value: value, text: value.toString(), enabled: enabled);

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
