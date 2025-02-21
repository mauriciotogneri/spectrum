import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:testflow/domain/state/auth/sign_in_state.dart';
import 'package:testflow/presentation/common/button/primary_text_button.dart';
import 'package:testflow/presentation/common/card/custom_card.dart';
import 'package:testflow/presentation/common/input/custom_password_input.dart';
import 'package:testflow/presentation/common/input/custom_text_input.dart';
import 'package:testflow/presentation/common/text/title_medium.dart';
import 'package:testflow/utils/validator.dart';

class SignInPage extends StatelessWidget {
  final SignInState state;

  const SignInPage._(this.state);

  factory SignInPage.instance() => SignInPage._(SignInState());

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const TitleMedium(text: 'Sign in'),
            const VBox(8),
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
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const VBox(10),
          CustomTextInput(
            hint: 'Email',
            controller: state.emailController,
            prefixIcon: Icons.email_outlined,
            validator: Validator.isNotEmpty,
            errorMessage: 'Email is required',
          ),
          const VBox(16),
          CustomPasswordInput(
            hint: 'Password',
            controller: state.passwordController,
            prefixIcon: Icons.lock_outlined,
            validator: Validator.isNotEmpty,
            errorMessage: 'Password is required',
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
    return SizedBox(
      width: double.infinity,
      child: PrimaryTextButton(
        text: 'Sign in',
        onPressed: () => state.onSignIn(context),
      ),
    );
  }
}
