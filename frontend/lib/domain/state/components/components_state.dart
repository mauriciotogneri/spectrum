import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
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
  bool loading = false;

  void onSubmitForm() {
    if (textFormKey.currentState!.validate()) {
      loading = true;
      notify();
    }
  }

  void onCancelSubmit() {
    loading = false;
    notify();
  }
}
