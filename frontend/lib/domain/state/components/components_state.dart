import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:testflow/presentation/common/input/custom_dropdown_single.dart';
import 'package:testflow/presentation/common/input/custom_text_input.dart';

class ComponentsState extends BaseState {
  final TextInputController queryController = TextInputController();
  final TextInputController nameController = TextInputController();
  final TextInputController occupationController = TextInputController();
  final TextInputController commentsController = TextInputController();
  final TextInputController descriptionController = TextInputController();

  final GlobalKey<FormState> textFormKey = GlobalKey<FormState>();
  final TextInputController emailController = TextInputController();
  final TextInputController passwordController = TextInputController();
  final CustomDropdownSingleController<Gender> genderController =
      CustomDropdownSingleController();
  final List<DropdownItem<Gender>> genderItems =
      Gender.values.map((e) => e.item).toList();
  bool loading = false;

  final CustomDropdownSingleController<Country> countryController =
      CustomDropdownSingleController();
  final List<DropdownItem<Country>> countryItems = [
    const Country(code: 'CH', name: 'Switzerland').item,
    const Country(code: 'ES', name: 'Spain').item,
    const Country(code: 'FR', name: 'France').item,
    const Country(code: 'DE', name: 'Germany').item,
    const Country(code: 'AU', name: 'Austria').item,
    const Country(code: 'BE', name: 'Belgium').item,
    const Country(code: 'IT', name: 'Italy').item,
    const Country(code: 'PT', name: 'Portugal').item,
    const Country(code: 'PL', name: 'Poland').item,
    const Country(code: 'NL', name: 'Netherlands').item,
  ];

  void onSubmitForm() {
    if (textFormKey.currentState!.validate()) {
      loading = true;
      notify();
    }
  }

  void onCancelSubmit() {
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

  DropdownItem<Country> get item => DropdownItem(value: this, text: toString());

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
