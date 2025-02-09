import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:testflow/domain/types/requirement_type.dart';
import 'package:testflow/presentation/common/button/primary_button.dart';
import 'package:testflow/presentation/common/button/secondary_button.dart';
import 'package:testflow/presentation/common/dropdown/dropdown_input.dart';
import 'package:testflow/presentation/common/input/text_input_field.dart';
import 'package:testflow/presentation/dialogs/base_dialog.dart';
import 'package:testflow/utils/navigation.dart';
import 'package:testflow/utils/validator.dart';

class CreateRequirementDialog extends StatelessWidget {
  final CreateRequirementDialogState state;

  const CreateRequirementDialog._(this.state);

  factory CreateRequirementDialog.instance({
    required OnCreateRequirement onCreateRequirement,
  }) =>
      CreateRequirementDialog._(CreateRequirementDialogState(
        onCreateRequirement: onCreateRequirement,
      ));

  @override
  Widget build(BuildContext context) {
    return StateProvider<CreateRequirementDialogState>(
      state: state,
      builder: (context, state) => BaseDialog(
        title: 'New requirement',
        width: 350,
        actions: [
          const SecondaryButton(
            text: 'Cancel',
            onPressed: Navigation.pop,
          ),
          PrimaryButton(
            text: 'Create',
            onPressed: () {
              if (state.formValid) {
                Navigation.pop();
                state.onCreate();
              }
            },
          ),
        ],
        content: FormFields(state),
      ),
    );
  }
}

class FormFields extends StatelessWidget {
  final CreateRequirementDialogState state;

  const FormFields(this.state);

  /*
    final String id;
    final String name;
    final String description;
  final RequirementType type;
  final RequirementStatus status;
  final RequirementImportance importance;
  final String component;
  final List<String> platforms;
  final List<String> tags;
  final int numberOfTestCases;
  */

  @override
  Widget build(BuildContext context) {
    return ShadForm(
      key: state.formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const DialogLabel('ID'),
                    TextInputField(
                      hint: 'ID',
                      isForm: true,
                      controller: state.idController,
                      validator: (value) => Validator.isNotEmpty(
                        value: value,
                        error: 'ID is required',
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const DialogLabel('Type'),
                    DropdownInput<RequirementType>(
                      width: 240,
                      values: RequirementType.values,
                      controller: state.typeFilterController,
                      allowDeselection: true,
                      isForm: true,
                      hint: 'Type',
                    ),
                  ],
                ),
              ),
            ],
          ),
          const DialogLabel('Name'),
          TextInputField(
            hint: 'Name',
            isForm: true,
            controller: state.nameController,
            validator: (value) => Validator.isNotEmpty(
              value: value,
              error: 'Name is required',
            ),
          ),
          const DialogLabel('Description'),
          TextInputField(
            hint: 'Description',
            isForm: true,
            maxLines: 5,
            controller: state.descriptionController,
          ),
          const VBox(16),
        ],
      ),
    );
  }
}

class CreateRequirementDialogState extends BaseState {
  final GlobalKey<ShadFormState> formKey = GlobalKey();
  final OnCreateRequirement onCreateRequirement;
  final TextInputController idController = TextInputController();
  final DropdownInputController<RequirementType> typeFilterController =
      DropdownInputController();
  final TextInputController nameController = TextInputController();
  final TextInputController descriptionController = TextInputController();

  CreateRequirementDialogState({required this.onCreateRequirement});

  bool get formValid => formKey.currentState!.validate();

  void onCreate() => onCreateRequirement(
        id: idController.text,
        name: nameController.text,
        description: descriptionController.text,
      );
}

typedef OnCreateRequirement = void Function({
  required String id,
  required String name,
  required String description,
});
