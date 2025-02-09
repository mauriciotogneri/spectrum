import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:testflow/presentation/common/button/primary_button.dart';
import 'package:testflow/presentation/common/button/secondary_button.dart';
import 'package:testflow/presentation/common/input/text_input_field.dart';
import 'package:testflow/presentation/dialogs/base_dialog.dart';
import 'package:testflow/utils/navigation.dart';

class CreateProjectDialog extends StatelessWidget {
  final CreateProjectDialogState state;

  const CreateProjectDialog._(this.state);

  factory CreateProjectDialog.instance({
    required OnCreateProject onCreateProject,
  }) =>
      CreateProjectDialog._(CreateProjectDialogState(
        onCreateProject: onCreateProject,
      ));

  @override
  Widget build(BuildContext context) {
    return StateProvider<CreateProjectDialogState>(
      state: state,
      builder: (context, state) => BaseDialog(
        title: 'New project',
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
  final CreateProjectDialogState state;

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
          const VBox(16),
        ],
      ),
    );
  }
}

class CreateProjectDialogState extends BaseState {
  final GlobalKey<ShadFormState> formKey = GlobalKey();
  final OnCreateProject onCreateProject;
  final TextInputController nameController = TextInputController();
  final TextInputController descriptionController = TextInputController();

  CreateProjectDialogState({required this.onCreateProject});

  bool get formValid => formKey.currentState!.validate();

  void onCreate() => onCreateProject(
        name: nameController.text,
        description: descriptionController.text,
      );
}

typedef OnCreateProject = void Function({
  required String name,
  required String description,
});
