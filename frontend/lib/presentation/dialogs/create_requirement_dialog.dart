import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:testflow/debug/data.dart';
import 'package:testflow/domain/types/requirement_importance.dart';
import 'package:testflow/domain/types/requirement_status.dart';
import 'package:testflow/domain/types/requirement_type.dart';
import 'package:testflow/presentation/common/button/primary_text_button.dart';
import 'package:testflow/presentation/common/button/secondary_text_button.dart';
import 'package:testflow/presentation/common/form/form_key.dart';
import 'package:testflow/presentation/common/input/custom_dropdown_multiple.dart';
import 'package:testflow/presentation/common/input/custom_dropdown_single.dart';
import 'package:testflow/presentation/common/input/custom_multiline_input.dart';
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
              const HBox(4),
              PrimaryTextButton(text: 'Create', onPressed: state.onCreate),
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
            errorMessage: 'Name is required',
          ),
          const VBox(16),
          CustomMultilineInput(
            minLines: 3,
            maxLines: 3,
            name: 'Description',
            controller: state.descriptionController,
          ),
          const VBox(16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomTextInput(
                      controller: state.idController,
                      name: 'ID',
                      errorMessage: 'ID is required',
                    ),
                  ],
                ),
              ),
              const HBox(16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomDropdownSingle<RequirementType>(
                      width: 240,
                      values: RequirementType.items,
                      controller: state.typeController,
                      name: 'Type',
                      errorMessage: 'Type is required',
                    ),
                  ],
                ),
              ),
            ],
          ),
          const VBox(16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomDropdownSingle<RequirementStatus>(
                      width: 240,
                      values: RequirementStatus.items,
                      controller: state.statusController,
                      name: 'Status',
                      errorMessage: 'Status is required',
                    ),
                  ],
                ),
              ),
              const HBox(16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomDropdownSingle<RequirementImportance>(
                      width: 240,
                      values: RequirementImportance.items,
                      controller: state.importanceController,
                      name: 'Importance',
                      errorMessage: 'Importance is required',
                    ),
                  ],
                ),
              ),
            ],
          ),
          const VBox(16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomDropdownSingle<String>(
                      width: 240,
                      values: DropdownItem.fromList(
                        Data.currentProject.components,
                      ),
                      controller: state.componentController,
                      name: 'Component',
                      errorMessage: 'Component is required',
                    ),
                  ],
                ),
              ),
              const HBox(16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomDropdownMultiple<String>(
                      width: 240,
                      values: DropdownItem.fromList(
                        Data.currentProject.platforms,
                      ),
                      controller: state.platformsController,
                      name: 'Platforms',
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
  final FormKey formKey = const FormKey();
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
  final CustomDropdownMultipleController<String> platformsController =
      CustomDropdownMultipleController();

  CreateRequirementDialogState({required this.onCreateRequirement});

  void onCreate() {
    if (formKey.validate()) {
      Navigation.pop();

      onCreateRequirement(
        name: nameController.text,
        description: descriptionController.text,
        id: idController.text,
        type: typeController.selected!,
        status: statusController.selected!,
        importance: importanceController.selected!,
        component: componentController.selected!,
        platforms: platformsController.selected,
      );
    }
  }
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
