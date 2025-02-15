import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:testflow/domain/types/requirement_importance.dart';
import 'package:testflow/domain/types/requirement_status.dart';
import 'package:testflow/domain/types/requirement_type.dart';
import 'package:testflow/presentation/common/button/primary_button.dart';
import 'package:testflow/presentation/common/button/secondary_button.dart';
import 'package:testflow/presentation/common/input/custom_dropdown_single.dart';
import 'package:testflow/presentation/common/input/custom_text_input.dart';
import 'package:testflow/presentation/common/text/input_label.dart';
import 'package:testflow/presentation/dialogs/base_dialog.dart';
import 'package:testflow/utils/navigation.dart';

class CreateRequirementDialog extends StatelessWidget {
  final CreateRequirementDialogState state;

  const CreateRequirementDialog._(this.state);

  factory CreateRequirementDialog.instance({
    required OnCreateRequirement onCreateRequirement,
  }) => CreateRequirementDialog._(
    CreateRequirementDialogState(onCreateRequirement: onCreateRequirement),
  );

  @override
  Widget build(BuildContext context) {
    return StateProvider<CreateRequirementDialogState>(
      state: state,
      builder:
          (context, state) => BaseDialog(
            title: 'New requirement',
            width: 350,
            actions: [
              const SecondaryButton(text: 'Cancel', onPressed: Navigation.pop),
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
    return Form(
      key: state.formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const InputLabel('Name'),
          CustomTextInput(
            autofocus: true,
            controller: state.nameController,
            //errorMessage: 'Name is required',
          ),
          const InputLabel('Description'),
          CustomTextInput(maxLines: 5, controller: state.descriptionController),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const InputLabel('ID'),
                    CustomTextInput(
                      controller: state.idController,
                      //errorMessage: 'ID is required',
                    ),
                  ],
                ),
              ),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InputLabel('Type'),
                    /*CustomDropdownSingle<RequirementType>(
                      width: 240,
                      values:
                          RequirementType.values
                              .map(DropdownItem.create)
                              .toList(),
                      controller: state.typeController,
                      allowDeselection: true,
                      errorMessage: 'Type is required',
                    ),*/
                  ],
                ),
              ),
            ],
          ),
          const Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InputLabel('Status'),
                    /*CustomDropdownSingle<RequirementStatus>(
                      width: 240,
                      values:
                          RequirementStatus.values
                              .map(DropdownItem.create)
                              .toList(),
                      controller: state.statusController,
                      allowDeselection: true,
                      errorMessage: 'Status is required',
                    ),*/
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InputLabel('Importance'),
                    /*CustomDropdownSingle<RequirementImportance>(
                      width: 240,
                      values:
                          RequirementImportance.values
                              .map(DropdownItem.create)
                              .toList(),
                      controller: state.importanceController,
                      allowDeselection: true,
                      errorMessage: 'Importance is required',
                    ),*/
                  ],
                ),
              ),
            ],
          ),
          const Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InputLabel('Component'),
                    /*CustomDropdownSingle<String>(
                      width: 240,
                      values:
                          Data.currentProject.components
                              .map(DropdownItem.create)
                              .toList(),
                      controller: state.componentController,
                      allowDeselection: true,
                      errorMessage: 'Component is required',
                    ),*/
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InputLabel('Platforms'),
                    /*CustomDropdownSingle<String>(
                      width: 240,
                      values:
                          Data.currentProject.platforms
                              .map(DropdownItem.create)
                              .toList(),
                      controller: state.platformsController,
                      allowDeselection: true,
                      errorMessage: 'Platforms is required',
                    ),*/
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
  final GlobalKey<FormState> formKey = GlobalKey();
  final OnCreateRequirement onCreateRequirement;
  final TextInputController idController = TextInputController();
  final CustomDropdownSingleController<RequirementType> typeController =
      CustomDropdownSingleController();
  final TextInputController nameController = TextInputController();
  final TextInputController descriptionController = TextInputController();
  final CustomDropdownSingleController<RequirementStatus> statusController =
      CustomDropdownSingleController();
  final CustomDropdownSingleController<RequirementImportance>
  importanceController = CustomDropdownSingleController();
  final CustomDropdownSingleController<String> componentController =
      CustomDropdownSingleController();
  final CustomDropdownSingleController<String> platformsController =
      CustomDropdownSingleController();

  CreateRequirementDialogState({required this.onCreateRequirement});

  bool get formValid => formKey.currentState!.validate();

  void onCreate() => onCreateRequirement(
    name: nameController.text,
    description: descriptionController.text,
    id: idController.text,
    type: typeController.selected!,
    status: statusController.selected!,
    importance: importanceController.selected!,
    component: componentController.selected!,
    platforms: [platformsController.selected!],
  );
}

typedef OnCreateRequirement =
    void Function({
      required String name,
      required String description,
      required String id,
      required RequirementType type,
      required RequirementStatus status,
      required RequirementImportance importance,
      required String component,
      required List<String> platforms,
    });
