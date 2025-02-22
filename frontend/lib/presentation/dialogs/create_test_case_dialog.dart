import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:testflow/domain/types/test_case_execution.dart';
import 'package:testflow/presentation/common/button/primary_text_button.dart';
import 'package:testflow/presentation/common/button/secondary_text_button.dart';
import 'package:testflow/presentation/common/form/form_key.dart';
import 'package:testflow/presentation/common/input/custom_dropdown_single.dart';
import 'package:testflow/presentation/common/input/custom_multiline_input.dart';
import 'package:testflow/presentation/common/input/custom_text_input.dart';
import 'package:testflow/presentation/dialogs/base_dialog.dart';

class CreateTestCaseDialog extends StatelessWidget {
  final CreateTestCaseDialogState state;

  const CreateTestCaseDialog._(this.state);

  factory CreateTestCaseDialog.instance({
    required OnCreateTestCase onCreateRequirement,
  }) => CreateTestCaseDialog._(
    CreateTestCaseDialogState(onCreateTestCase: onCreateRequirement),
  );

  @override
  Widget build(BuildContext context) {
    return StateProvider<CreateTestCaseDialogState>(
      state: state,
      builder:
          (context, state) => BaseDialog(
            title: 'New test case',
            width: 500,
            actions: [
              SecondaryTextButton(
                text: 'Cancel',
                onPressed: Navigator.of(context).pop,
              ),
              const HBox(4),
              PrimaryTextButton(
                text: 'Create',
                onPressed: () => state.onCreate(context),
              ),
            ],
            content: FormFields(state),
          ),
    );
  }
}

class FormFields extends StatelessWidget {
  final CreateTestCaseDialogState state;

  const FormFields(this.state);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: state.formKey.key,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              CustomTextInput(
                width: 300,
                autofocus: true,
                controller: state.nameController,
                name: 'Name',
                errorMessage: 'Name is required',
              ),
              const HBox(16),
              Expanded(
                child: CustomDropdownSingle<TestCaseExecution>(
                  values: TestCaseExecution.items,
                  controller: state.executionController,
                  name: 'Execution',
                  errorMessage: 'Execution is required',
                ),
              ),
            ],
          ),
          const VBox(16),
          CustomMultilineInput(
            width: 500,
            controller: state.preconditionsController,
            minLines: 5,
            maxLines: 5,
            name: 'Preconditions',
            errorMessage: 'Preconditions is required',
          ),
          const VBox(16),
          CustomMultilineInput(
            width: 500,
            controller: state.stepsController,
            minLines: 5,
            maxLines: 5,
            name: 'Steps',
            errorMessage: 'Steps is required',
          ),
          const VBox(16),
          CustomMultilineInput(
            width: 500,
            controller: state.expectedController,
            minLines: 5,
            maxLines: 5,
            name: 'Expected',
            errorMessage: 'Expected is required',
          ),
          const VBox(16),
        ],
      ),
    );
  }
}

class CreateTestCaseDialogState extends BaseState {
  final FormKey formKey = FormKey();
  final OnCreateTestCase onCreateTestCase;
  final CustomTextInputController nameController = CustomTextInputController();
  final CustomDropdownSingleController<TestCaseExecution> executionController =
      CustomDropdownSingleController();
  final CustomTextInputController preconditionsController =
      CustomTextInputController();
  final CustomTextInputController stepsController = CustomTextInputController();
  final CustomTextInputController expectedController =
      CustomTextInputController();

  CreateTestCaseDialogState({required this.onCreateTestCase});

  void onCreate(BuildContext context) {
    if (formKey.validate()) {
      Navigator.of(context).pop();

      onCreateTestCase(
        name: nameController.text,
        execution: executionController.selected!,
        preconditions: preconditionsController.text,
        steps: stepsController.text,
        expected: expectedController.text,
      );
    }
  }
}

typedef OnCreateTestCase =
    void Function({
      required String name,
      required TestCaseExecution execution,
      required String preconditions,
      required String steps,
      required String expected,
    });
