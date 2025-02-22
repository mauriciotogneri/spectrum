import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:testflow/debug/data.dart';
import 'package:testflow/extensions/build_context_extension.dart';
import 'package:testflow/presentation/common/form/form_key.dart';
import 'package:testflow/presentation/common/input/custom_text_input.dart';

class SignInState extends BaseState {
  final FormKey formKey = FormKey();
  final CustomTextInputController emailController = CustomTextInputController();
  final CustomTextInputController passwordController =
      CustomTextInputController();

  @override
  void onLoad() {
    emailController.text = 'demo@email.com';
    passwordController.text = '123456';
    notify();
  }

  void onSignIn(BuildContext context) {
    if (formKey.validate()) {
      _signIn(context);
    }
  }

  void _signIn(BuildContext context) =>
      context.dashboard(projectId: Data.currentProject.id);
}
