import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:testflow/domain/types/requirement_importance.dart';
import 'package:testflow/domain/types/requirement_status.dart';
import 'package:testflow/domain/types/requirement_type.dart';
import 'package:testflow/presentation/common/button/primary_text_button.dart';
import 'package:testflow/presentation/common/button/secondary_text_button.dart';
import 'package:testflow/presentation/common/input/custom_dropdown_single.dart';
import 'package:testflow/presentation/common/input/custom_text_input.dart';
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
              const SecondaryTextButton(
                text: 'Cancel',
                onPressed: Navigation.pop,
              ),
              PrimaryTextButton(
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
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomTextInput(
            autofocus: true,
            controller: state.nameController,
            name: 'Name',
            //errorMessage: 'Name is required',
          ),
          CustomTextInput(
            maxLines: 5,
            controller: state.descriptionController,
            name: 'Description',
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomTextInput(
                      controller: state.idController,
                      name: 'ID',
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
                    /*CustomDropdownSingle<RequirementType>(
                      width: 240,
                      values:
                          RequirementType.values
                              .map(DropdownItem.create)
                              .toList(),
                      controller: state.typeController,
                      allowDeselection: true,
                      name: 'Type',
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
                    /*CustomDropdownSingle<RequirementStatus>(
                      width: 240,
                      values:
                          RequirementStatus.values
                              .map(DropdownItem.create)
                              .toList(),
                      controller: state.statusController,
                      allowDeselection: true,
                      name: 'Status',
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
                    /*CustomDropdownSingle<RequirementImportance>(
                      width: 240,
                      values:
                          RequirementImportance.values
                              .map(DropdownItem.create)
                              .toList(),
                      controller: state.importanceController,
                      allowDeselection: true,
                      name: 'Importance',
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
                    /*CustomDropdownSingle<String>(
                      width: 240,
                      values:
                          Data.currentProject.components
                              .map(DropdownItem.create)
                              .toList(),
                      controller: state.componentController,
                      allowDeselection: true,
                      name: 'Component',
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
                    /*CustomDropdownSingle<String>(
                      width: 240,
                      values:
                          Data.currentProject.platforms
                              .map(DropdownItem.create)
                              .toList(),
                      controller: state.platformsController,
                      allowDeselection: true,
                      name: 'Platforms',
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
  final CustomTextInputController idController = CustomTextInputController();
  final CustomDropdownSingleController<RequirementType> typeController =
      CustomDropdownSingleController();
  final CustomTextInputController nameController = CustomTextInputController();
  final CustomTextInputController descriptionController =
      CustomTextInputController();
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
