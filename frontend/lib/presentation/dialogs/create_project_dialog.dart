import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:testflow/presentation/common/button/primary_text_button.dart';
import 'package:testflow/presentation/common/button/secondary_text_button.dart';
import 'package:testflow/presentation/common/form/form_key.dart';
import 'package:testflow/presentation/common/input/custom_multiline_input.dart';
import 'package:testflow/presentation/common/input/custom_text_input.dart';
import 'package:testflow/presentation/dialogs/base_dialog.dart';

class CreateProjectDialog extends StatelessWidget {
  final CreateProjectDialogState state;

  const CreateProjectDialog._(this.state);

  factory CreateProjectDialog.instance({
    required OnCreateProject onCreateProject,
  }) => CreateProjectDialog._(
    CreateProjectDialogState(onCreateProject: onCreateProject),
  );

  @override
  Widget build(BuildContext context) {
    return StateProvider<CreateProjectDialogState>(
      state: state,
      builder:
          (context, state) => BaseDialog(
            title: 'New project',
            width: 350,
            actions: [
              SecondaryTextButton(
                text: 'Cancel',
                onPressed: Navigator.of(context).pop,
              ),
              PrimaryTextButton(
                text: 'Create',
                onPressed: () {
                  if (state.formKey.validate()) {
                    Navigator.of(context).pop();
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
  final CreateProjectDialogState state;

  const FormFields(this.state);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: state.formKey.key,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomTextInput(
            name: 'Name',
            autofocus: true,
            controller: state.nameController,
            errorMessage: 'Name is required',
          ),
          const VBox(16),
          CustomMultilineInput(
            name: 'Description',
            minLines: 5,
            maxLines: 5,
            controller: state.descriptionController,
          ),
        ],
      ),
    );
  }
}

class CreateProjectDialogState extends BaseState {
  final FormKey formKey = FormKey();
  final OnCreateProject onCreateProject;
  final CustomTextInputController nameController = CustomTextInputController();
  final CustomTextInputController descriptionController =
      CustomTextInputController();

  CreateProjectDialogState({required this.onCreateProject});

  void onCreate() => onCreateProject(
    name: nameController.text,
    description: descriptionController.text,
  );
}

typedef OnCreateProject =
    void Function({required String name, required String description});
