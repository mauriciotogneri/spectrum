import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:testflow/presentation/common/input/text_input_field.dart';
import 'package:testflow/utils/navigation.dart';

class SignInState extends BaseState {
  final GlobalKey<ShadFormState> formKey = GlobalKey();
  final TextInputController emailController = TextInputController();
  final TextInputController passwordController = TextInputController();

  bool get formFilled =>
      emailController.text.isNotEmpty && passwordController.text.isNotEmpty;

  @override
  void onLoad() {
    emailController.text = 'demo@email.com';
    passwordController.text = '123456';
    notify();
  }

  void onSignIn() {
    //emailController.unfocus();
    //passwordController.unfocus();

    _signIn();
  }

  void _signIn() => Navigation.dashboardScreen();
}
