import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:testflow/presentation/common/input/custom_text_input.dart';
import 'package:testflow/utils/navigation.dart';

class SignInState extends BaseState {
  final GlobalKey<FormState> formKey = GlobalKey();
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
