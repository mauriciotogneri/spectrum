import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:testflow/domain/state/components/components_state.dart';
import 'package:testflow/presentation/common/button/primary_button.dart';
import 'package:testflow/presentation/common/button/secondary_button.dart';
import 'package:testflow/presentation/common/card/custom_card.dart';
import 'package:testflow/presentation/common/input/custom_dropdown_single.dart';
import 'package:testflow/presentation/common/input/custom_password_input.dart';
import 'package:testflow/presentation/common/input/custom_text_input.dart';
import 'package:testflow/presentation/common/layout/pane.dart';
import 'package:testflow/presentation/common/layout/scrollable_column.dart';
import 'package:testflow/presentation/common/text/body_large.dart';
import 'package:testflow/presentation/common/text/body_medium.dart';
import 'package:testflow/presentation/common/text/body_small.dart';
import 'package:testflow/presentation/common/text/title_large.dart';
import 'package:testflow/presentation/common/text/title_medium.dart';
import 'package:testflow/presentation/common/text/title_small.dart';
import 'package:testflow/utils/palette.dart';
import 'package:testflow/utils/validator.dart';

class ComponentsView extends StatelessWidget {
  final ComponentsState state;

  const ComponentsView._(this.state);

  factory ComponentsView.instance() => ComponentsView._(ComponentsState());

  @override
  Widget build(BuildContext context) {
    return StateProvider<ComponentsState>(
      state: state,
      builder:
          (context, state) => Pane.normal(
            header: const Text('COMPONENTS'),
            content: Content(state),
          ),
    );
  }
}

class Content extends StatelessWidget {
  final ComponentsState state;

  const Content(this.state);

  @override
  Widget build(BuildContext context) {
    return ScrollableColumn(
      children: [
        const VBox(16),
        const Texts(),
        const VBox(16),
        TextInputs(state),
        const VBox(16),
        TextInputForm(state),
        const VBox(16),
        const ButtonFields(),
        const VBox(16),
        DropdownFields(state),
      ],
    );
  }
}

class Texts extends StatelessWidget {
  const Texts();

  @override
  Widget build(BuildContext context) {
    return const CustomCard(
      expand: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          TitleLarge(text: 'Title large'),
          VBox(8),
          TitleMedium(text: 'Title medium'),
          VBox(8),
          TitleSmall(text: 'Title small'),
          VBox(8),
          BodyLarge(text: 'Body large'),
          VBox(8),
          BodyMedium(text: 'Body medium'),
          VBox(8),
          BodySmall(text: 'Body small'),
        ],
      ),
    );
  }
}

class TextInputs extends StatelessWidget {
  final ComponentsState state;

  const TextInputs(this.state);

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      expand: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              CustomTextInput(
                width: 300,
                hint: 'Query',
                canClear: true,
                controller: state.queryController,
                prefixIcon: Icons.search,
              ),
              const HBox(16),
              CustomTextInput(
                width: 300,
                hint: 'Name',
                controller: state.nameController,
                prefixIcon: Icons.person_outline,
              ),
              const HBox(16),
              CustomTextInput(
                width: 300,
                hint: 'Occupation',
                enabled: false,
                controller: state.occupationController,
                prefixIcon: Icons.work_outline,
              ),
              const HBox(16),
              Expanded(
                child: CustomTextInput(
                  hint: 'Comments',
                  controller: state.commentsController,
                ),
              ),
            ],
          ),
          const VBox(16),
          CustomTextInput(
            width: 616,
            minLines: 5,
            maxLines: 5,
            hint: 'Description',
            controller: state.descriptionController,
            keyboardType: TextInputType.multiline,
          ),
        ],
      ),
    );
  }
}

class TextInputForm extends StatelessWidget {
  final ComponentsState state;

  const TextInputForm(this.state);

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      width: 332,
      child: Form(
        key: state.textFormKey,
        child: Column(
          children: [
            CustomTextInput(
              width: 300,
              hint: 'Email',
              controller: state.emailController,
              prefixIcon: Icons.email_outlined,
              validator: Validator.isNotEmpty,
              errorMessage: 'Email is required',
            ),
            const VBox(16),
            CustomPasswordInput(
              width: 300,
              hint: 'Password',
              controller: state.passwordController,
              prefixIcon: Icons.lock_outline_rounded,
              validator: Validator.isNotEmpty,
              errorMessage: 'Password is required',
            ),
            const VBox(16),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: SecondaryButton(
                    text: 'Cancel',
                    onPressed: state.onCancelSubmit,
                  ),
                ),
                const HBox(16),
                Expanded(
                  child: PrimaryButton(
                    text: 'Submit',
                    onPressed: state.onSubmitForm,
                    loading: state.loading,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ButtonFields extends StatelessWidget {
  const ButtonFields();

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SecondaryButton(
            text: 'Cancel',
            width: 200,
            color: Palette.borderButtonError,
            icon: Icons.close,
            onPressed: () {},
          ),
          const VBox(16),
          PrimaryButton(
            text: 'Stop',
            width: 200,
            icon: Icons.stop,
            color: Palette.borderButtonError,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

class DropdownFields extends StatelessWidget {
  final ComponentsState state;

  const DropdownFields(this.state);

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomDropdownSingle(
            width: 300,
            values: state.countryItems,
            hint: 'Country',
            controller: state.countryController,
            onSelected: state.onCountrySelected,
          ),
          const VBox(1000),
        ],
      ),
    );
  }
}
