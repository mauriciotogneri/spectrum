import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:testflow/domain/state/auth/sign_in_state.dart';
import 'package:testflow/presentation/common/primary_button.dart';

class SignInScreen extends StatelessWidget {
  final SignInState state;

  const SignInScreen._(this.state);

  factory SignInScreen.instance() => SignInScreen._(SignInState());

  @override
  Widget build(BuildContext context) {
    return StateProvider<SignInState>(
      state: state,
      builder: (context, state) => Body(state),
    );
  }
}

class Body extends StatelessWidget {
  final SignInState state;

  const Body(this.state);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Content(state),
      ),
    );
  }
}

class Content extends StatelessWidget {
  final SignInState state;

  const Content(this.state);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FormInputs(state),
        const VBox(16),
        SignInButton(state),
      ],
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
        children: [
          const VBox(10),
          TextField(
            controller: state.emailController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Email',
            ),
          ),
          const VBox(16),
          TextField(
            controller: state.passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Password',
            ),
          ),
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
      onPressed: state.formFilled ? state.onSignIn : null,
    );
  }
}
