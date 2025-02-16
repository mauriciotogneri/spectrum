import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:testflow/domain/state/components/components_state.dart';
import 'package:testflow/domain/types/requirement_importance.dart';
import 'package:testflow/domain/types/requirement_status.dart';
import 'package:testflow/domain/types/requirement_type.dart';
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
      children: [const VBox(16), Row1(state), const VBox(16), Row2(state)],
    );
  }
}

class Row1 extends StatelessWidget {
  final ComponentsState state;

  const Row1(this.state);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row1Column1(),
        const HBox(16),
        Expanded(child: Row1Column2(state)),
      ],
    );
  }
}

class Row1Column1 extends StatelessWidget {
  const Row1Column1();

  @override
  Widget build(BuildContext context) {
    return const CustomCard(
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

class Row1Column2 extends StatelessWidget {
  final ComponentsState state;

  const Row1Column2(this.state);

  @override
  Widget build(BuildContext context) {
    return CustomCard(
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

class Row2 extends StatelessWidget {
  final ComponentsState state;

  const Row2(this.state);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row2Column1(state),
        const HBox(16),
        const Row2Column2(),
        const HBox(16),
        Row2Column3(state),
        const HBox(16),
        const Row2Column4(),
      ],
    );
  }
}

class Row2Column1 extends StatelessWidget {
  final ComponentsState state;

  const Row2Column1(this.state);

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      width: 332,
      child: Form(
        key: state.signInFormKey,
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
            CustomDropdownSingle(
              width: 300,
              icon: Icons.person_outline,
              values: state.genderItems,
              hint: 'Gender',
              controller: state.genderController,
              errorMessage: 'Gender is required',
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

class Row2Column2 extends StatelessWidget {
  const Row2Column2();

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

class Row2Column3 extends StatelessWidget {
  final ComponentsState state;

  const Row2Column3(this.state);

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomDropdownSingle(
            width: 300,
            icon: Icons.flag_outlined,
            values: state.countryItems,
            hint: 'Country',
            allowDeselection: true,
            controller: state.countryController,
          ),
          const VBox(16),
          CustomDropdownSingle(
            width: 200,
            values: state.dayItems,
            hint: 'Day',
            controller: state.dayController,
          ),
        ],
      ),
    );
  }
}

class Row2Column4 extends StatelessWidget {
  const Row2Column4();

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              RequirementImportance.critical.chip,
              const VBox(16),
              RequirementImportance.high.chip,
              const VBox(16),
              RequirementImportance.medium.chip,
              const VBox(16),
              RequirementImportance.low.chip,
            ],
          ),
          const HBox(16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              RequirementStatus.draft.chip,
              const VBox(16),
              RequirementStatus.active.chip,
              const VBox(16),
              RequirementStatus.inactive.chip,
            ],
          ),
          const HBox(16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              RequirementType.functional.chip,
              const VBox(16),
              RequirementType.non_functional.chip,
            ],
          ),
        ],
      ),
    );
  }
}
