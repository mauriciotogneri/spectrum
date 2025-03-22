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
    passwordController.text = 'QWEqwe123!';
    notify();
  }

  void onSignIn(BuildContext context) {
    if (formKey.validate()) {
      _signIn(context);
    }
  }

  Future _signIn(BuildContext context) async {
    try {
      /*await Authentication.signIn(
        email: emailController.text,
        password: passwordController.text,
      );*/
      if (context.mounted) {
        context.dashboard(projectId: Data.currentProject.id);
      }
    } catch (e) {
      print(e);
    }
  }
}
