import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:testflow/presentation/common/form/form_key.dart';
import 'package:testflow/presentation/common/input/custom_dropdown_multiple.dart';
import 'package:testflow/presentation/common/input/custom_dropdown_single.dart';
import 'package:testflow/presentation/common/input/custom_text_input.dart';

class ComponentsState extends BaseState {
  // Row 1 / Column 2
  final CustomTextInputController queryController = CustomTextInputController();
  final CustomTextInputController nameController = CustomTextInputController();
  final CustomTextInputController occupationController =
      CustomTextInputController();
  final CustomTextInputController commentsController =
      CustomTextInputController();
  final CustomTextInputController descriptionController =
      CustomTextInputController();

  // Row 2 / Column 1
  final FormKey signInFormKey = const FormKey();
  final CustomTextInputController emailController = CustomTextInputController();
  final CustomTextInputController passwordController =
      CustomTextInputController();
  final CustomDropdownSingleController<Gender> genderController =
      CustomDropdownSingleController();
  final List<DropdownItem<Gender>> genderItems =
      Gender.values.map((e) => e.item).toList();
  bool loading = false;

  // Row 2 / Column 3
  final CustomDropdownSingleController<Country> countryController =
      CustomDropdownSingleController();
  final List<DropdownItem<Country>> countryItems = [
    const Country(code: 'CH', name: 'Switzerland').item(),
    const Country(code: 'ES', name: 'Spain').item(),
    const Country(code: 'FR', name: 'France').item(),
    const Country(code: 'DE', name: 'Germany').item(),
    const Country(code: 'AU', name: 'Austria').item(),
    const Country(code: 'BE', name: 'Belgium').item(),
    const Country(code: 'IT', name: 'Italy').item(),
    const Country(code: 'PT', name: 'Portugal').item(),
    const Country(code: 'PL', name: 'Poland').item(),
    const Country(code: 'NL', name: 'Netherlands').item(false),
  ];
  final CustomDropdownSingleController<String> dayController =
      CustomDropdownSingleController();
  final List<DropdownItem<String>> dayItems = [
    DropdownItem.create('Monday'),
    DropdownItem.create('Tuesday'),
    DropdownItem.create('Wednesday'),
    DropdownItem.create('Thursday'),
    DropdownItem.create('Friday'),
    DropdownItem.create('Saturday', false),
    DropdownItem.create('Sunday', false),
  ];
  final CustomDropdownMultipleController<String> monthController =
      CustomDropdownMultipleController();
  final List<DropdownItem<String>> monthItems = [
    DropdownItem.create('January'),
    DropdownItem.create('February'),
    DropdownItem.create('March'),
    DropdownItem.create('April'),
    DropdownItem.create('May'),
    DropdownItem.create('June'),
    DropdownItem.create('July'),
    DropdownItem.create('August'),
    DropdownItem.create('September'),
    DropdownItem.create('October', false),
    DropdownItem.create('November', false),
    DropdownItem.create('December', false),
  ];

  void onSubmitForm() {
    if (signInFormKey.validate()) {
      loading = true;
      notify();
    }
  }

  void onCancelSubmit() {
    signInFormKey.reset();
    emailController.clear();
    passwordController.clear();
    genderController.clear();
    loading = false;
    notify();
  }
}

class Country {
  final String code;
  final String name;

  const Country({required this.code, required this.name});

  DropdownItem<Country> item([bool enabled = true]) =>
      DropdownItem(value: this, text: toString(), enabled: enabled);

  String get flag => code.toUpperCase().replaceAllMapped(
    RegExp(r'[A-Z]'),
    (match) =>
        String.fromCharCode((match.group(0)?.codeUnitAt(0) ?? 0) + 127397),
  );

  @override
  String toString() => '$flag  $name';
}

enum Gender {
  male,
  female;

  String get localized {
    switch (this) {
      case Gender.male:
        return 'Male';
      case Gender.female:
        return 'Female';
    }
  }

  IconData get icon {
    switch (this) {
      case Gender.male:
        return Icons.male;
      case Gender.female:
        return Icons.female;
    }
  }

  DropdownItem<Gender> get item =>
      DropdownItem(value: this, text: toString(), icon: icon);

  @override
  String toString() => localized;
}
