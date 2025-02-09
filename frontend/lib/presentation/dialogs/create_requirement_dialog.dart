import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:testflow/debug/data.dart';
import 'package:testflow/domain/types/requirement_importance.dart';
import 'package:testflow/domain/types/requirement_status.dart';
import 'package:testflow/domain/types/requirement_type.dart';
import 'package:testflow/presentation/common/button/primary_button.dart';
import 'package:testflow/presentation/common/button/secondary_button.dart';
import 'package:testflow/presentation/common/dropdown/dropdown_input_multiple.dart';
import 'package:testflow/presentation/common/dropdown/dropdown_input_single.dart';
import 'package:testflow/presentation/common/input/text_input_field.dart';
import 'package:testflow/presentation/dialogs/base_dialog.dart';
import 'package:testflow/utils/navigation.dart';

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

  @override
  Widget build(BuildContext context) {
    return ShadForm(
      key: state.formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const DialogLabel('Name'),
          TextInputField(
            hint: 'Name',
            isForm: true,
            controller: state.nameController,
            errorMessage: 'Name is required',
          ),
          const DialogLabel('Description'),
          TextInputField(
            hint: 'Description',
            isForm: true,
            maxLines: 5,
            controller: state.descriptionController,
          ),
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
                      errorMessage: 'ID is required',
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
                    DropdownInputSingle<RequirementType>(
                      width: 240,
                      values: RequirementType.values,
                      controller: state.typeController,
                      allowDeselection: true,
                      isForm: true,
                      hint: 'Type',
                      errorMessage: 'Type is required',
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const DialogLabel('Status'),
                    DropdownInputSingle<RequirementStatus>(
                      width: 240,
                      values: RequirementStatus.values,
                      controller: state.statusController,
                      allowDeselection: true,
                      isForm: true,
                      hint: 'Status',
                      errorMessage: 'Status is required',
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const DialogLabel('Importance'),
                    DropdownInputSingle<RequirementImportance>(
                      width: 240,
                      values: RequirementImportance.values,
                      controller: state.importanceController,
                      allowDeselection: true,
                      isForm: true,
                      hint: 'Importance',
                      errorMessage: 'Importance is required',
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const DialogLabel('Component'),
                    DropdownInputSingle<String>(
                      width: 240,
                      values: Data.currentProject.components,
                      controller: state.componentController,
                      allowDeselection: true,
                      isForm: true,
                      hint: 'Component',
                      errorMessage: 'Component is required',
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const DialogLabel('Platforms'),
                    DropdownInputMultiple<String>(
                      width: 240,
                      values: Data.currentProject.platforms,
                      controller: state.platformsController,
                      allowDeselection: true,
                      isForm: true,
                      hint: 'Platforms',
                      errorMessage: 'Platforms is required',
                    ),
                  ],
                ),
              ),
            ],
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
  final DropdownInputSingleController<RequirementType> typeController =
      DropdownInputSingleController();
  final TextInputController nameController = TextInputController();
  final TextInputController descriptionController = TextInputController();
  final DropdownInputSingleController<RequirementStatus> statusController =
      DropdownInputSingleController();
  final DropdownInputSingleController<RequirementImportance>
      importanceController = DropdownInputSingleController();
  final DropdownInputSingleController<String> componentController =
      DropdownInputSingleController();
  final DropdownInputMultipleController<String> platformsController =
      DropdownInputMultipleController();

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
