import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:testflow/domain/state/auth/sign_in_state.dart';
import 'package:testflow/presentation/common/button/primary_button.dart';
import 'package:testflow/presentation/common/card/custom_card.dart';
import 'package:testflow/presentation/common/input/custom_password_input.dart';
import 'package:testflow/presentation/common/input/custom_text_input.dart';
import 'package:testflow/presentation/common/text/title_medium.dart';

class SignInScreen extends StatelessWidget {
  final SignInState state;

  const SignInScreen._(this.state);

  factory SignInScreen.instance() => SignInScreen._(SignInState());

  @override
  Widget build(BuildContext context) {
    return StateProvider<SignInState>(
      state: state,
      builder: (context, state) => Scaffold(body: Content(state)),
    );
  }
}

class Content extends StatelessWidget {
  final SignInState state;

  const Content(this.state);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomCard(
        width: 350,
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const TitleMedium(text: 'Sign in'),
            FormInputs(state),
            SignInButton(state),
          ],
        ),
      ),
    );
  }
}

class FormInputs extends StatelessWidget {
  final SignInState state;

  const FormInputs(this.state);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: state.formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const VBox(10),
          CustomTextInput(
            hint: 'Email',
            controller: state.emailController,
            onChange: (_) => state.notify(),
            prefixIcon: const TextInputIcon(Icons.email_outlined),
          ),
          const VBox(16),
          CustomPasswordInput(
            hint: 'Password',
            controller: state.passwordController,
            onChange: (_) => state.notify(),
            prefixIcon: const TextInputIcon(Icons.lock_outlined),
          ),
          const VBox(16),
        ],
      ),
    );
  }
}

class SignInButton extends StatelessWidget {
  final SignInState state;

  const SignInButton(this.state);

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      text: 'Sign in',
      onPressed: state.onSignIn,
      enabled: state.formFilled,
      expanded: true,
    );
  }
}
