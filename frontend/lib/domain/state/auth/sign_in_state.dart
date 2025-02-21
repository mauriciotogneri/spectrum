import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:testflow/presentation/common/form/form_key.dart';
import 'package:testflow/presentation/common/input/custom_text_input.dart';

class SignInState extends BaseState {
  final FormKey formKey = const FormKey();
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

  void _signIn(BuildContext context) => context.go('/projects/1/dashboard');
}
