import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:testflow/presentation/common/button/primary_text_button.dart';
import 'package:testflow/presentation/common/button/secondary_text_button.dart';
import 'package:testflow/presentation/common/input/custom_text_input.dart';
import 'package:testflow/presentation/common/text/title_small.dart';
import 'package:testflow/presentation/dialogs/base_dialog.dart';
import 'package:testflow/utils/navigation.dart';

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
  final CreateProjectDialogState state;

  const FormFields(this.state);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: state.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const TitleSmall(text: 'Name'),
          CustomTextInput(
            controller: state.nameController,
            //errorMessage: 'Name is required',
          ),
          const TitleSmall(text: 'Description'),
          CustomTextInput(maxLines: 5, controller: state.descriptionController),
          const VBox(16),
        ],
      ),
    );
  }
}

class CreateProjectDialogState extends BaseState {
  final GlobalKey<FormState> formKey = GlobalKey();
  final OnCreateProject onCreateProject;
  final CustomTextInputController nameController = CustomTextInputController();
  final CustomTextInputController descriptionController =
      CustomTextInputController();

  CreateProjectDialogState({required this.onCreateProject});

  bool get formValid => formKey.currentState!.validate();

  void onCreate() => onCreateProject(
    name: nameController.text,
    description: descriptionController.text,
  );
}

typedef OnCreateProject =
    void Function({required String name, required String description});
