import 'package:flutter/material.dart';

class FormKey {
  final GlobalKey<FormState> _formKey = GlobalKey();

  GlobalKey<FormState> get key => _formKey;

  bool validate() => _formKey.currentState?.validate() ?? false;

  void reset() => _formKey.currentState?.reset();
}
