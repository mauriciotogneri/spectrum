import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:testflow/presentation/common/form/form_input.dart';
import 'package:testflow/presentation/common/icon/input_icon.dart';
import 'package:testflow/presentation/common/input/custom_dropdown_single.dart';
import 'package:testflow/presentation/common/input/custom_input.dart';
import 'package:testflow/utils/palette.dart';

class CustomDropdownMultiple<T> extends StatelessWidget {
  final CustomDropdownMultipleController<T> controller;
  final List<DropdownItem<T>> values;
  final String? name;
  final String? hint;
  final IconData? icon;
  final double? width;
  final bool enabled;
  final Function(List<T>)? onSelected;
  final String? errorMessage;

  const CustomDropdownMultiple({
    required this.controller,
    required this.values,
    this.name,
    this.hint,
    this.icon,
    this.width,
    this.onSelected,
    this.errorMessage,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return StateProvider<CustomDropdownMultipleController<T>>(
      state: controller,
      builder:
          (context, state) => FormInput(
            name: name,
            errorMessage: errorMessage,
            controller: controller,
            builder:
                (hasError) => SizedBox(
                  width: width,
                  height: CustomInput.HEIGHT,
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
                              onSelected: _onSelected,
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
                                    labelWidget:
                                        (item.value is Dropdownable)
                                            ? (item.value as Dropdownable)
                                                .dropdownItem
                                            : null,
                                    enabled: item.enabled,
                                    leadingIcon: InputIcon.create(item.icon),
                                    trailingIcon:
                                        controller.selected.contains(item.value)
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
                                size: 14,
                              ),
                              selectedTrailingIcon: const InputIcon(
                                icon: Icons.keyboard_arrow_up_rounded,
                                size: 14,
                              ),
                              inputDecorationTheme: InputDecorationTheme(
                                contentPadding: EdgeInsets.only(
                                  left: (icon == null) ? 12 : 0,
                                  right: 12,
                                ),
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

  void _onSelected(T? element) {
    if (element != null) {
      onSelected?.call(controller.selected);
      controller._onSelected(element);
    }
  }
}

class CustomDropdownMultipleController<T>
    extends CustomInputController<List<T>> {
  final TextEditingController _controller = TextEditingController();
  final List<T> _selected = [];

  List<T> get selected => _selected;

  @override
  List<T> get value => selected;

  @override
  bool get isEmpty => value.isEmpty;

  void clear() {
    select([]);
  }

  void select(List<T> value) {
    _selected.clear();
    _selected.addAll(value);
    _updateDisplay();
  }

  void _onSelected(T value) {
    if (_selected.contains(value)) {
      _selected.remove(value);
    } else {
      _selected.add(value);
    }

    _updateDisplay();
    notify();
  }

  void _updateDisplay() {
    if (selected.isEmpty) {
      _controller.text = '';
    } else if (selected.length == 1) {
      _controller.text = selected.first.toString();
    } else {
      _controller.text = '${selected.length} selected';
    }
  }
}
