import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:testflow/utils/navigation.dart';

class SignInState extends BaseState {
  final Key formKey = UniqueKey();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool get formFilled =>
      emailController.text.isNotEmpty && passwordController.text.isNotEmpty;

  @override
  void onLoad() {
    emailController.text = 'demo@email.com';
    passwordController.text = '123456';
  }

  void onSignIn() {
    //emailController.unfocus();
    //passwordController.unfocus();

    _signIn();
  }

  void _signIn() => Navigation.dashboardScreen();
}
