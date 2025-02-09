import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:testflow/domain/state/auth/sign_in_state.dart';
import 'package:testflow/presentation/common/button/primary_button.dart';
import 'package:testflow/presentation/common/input/password_input_field.dart';
import 'package:testflow/presentation/common/input/text_input_field.dart';
import 'package:testflow/presentation/common/text/title_4.dart';

class SignInScreen extends StatelessWidget {
  final SignInState state;

  const SignInScreen._(this.state);

  factory SignInScreen.instance() => SignInScreen._(SignInState());

  @override
  Widget build(BuildContext context) {
    return StateProvider<SignInState>(
      state: state,
      builder: (context, state) => Scaffold(
        body: Content(state),
      ),
    );
  }
}

class Content extends StatelessWidget {
  final SignInState state;

  const Content(this.state);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ShadCard(
        width: 350,
        title: const Title4(text: 'Sign in'),
        footer: SignInButton(state),
        child: FormInputs(state),
      ),
    );
  }
}

class FormInputs extends StatelessWidget {
  final SignInState state;

  const FormInputs(this.state);

  @override
  Widget build(BuildContext context) {
    return ShadForm(
      key: state.formKey,
      child: Column(
        children: [
          const VBox(10),
          TextInputField(
            hint: 'Email',
            controller: state.emailController,
            onChange: (_) => state.notify(),
            prefixIcon: const TextInputIcon(Icons.email_outlined),
          ),
          const VBox(16),
          PasswordInputField(
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
