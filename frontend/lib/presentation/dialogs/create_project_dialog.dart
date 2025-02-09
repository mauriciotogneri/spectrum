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
    required CreateProjectCallback onCreateProject,
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
            //enabled: state.formFilled,
            onPressed: () {
              //Navigation.pop();
              //state.onCreate();
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
          const VBox(16),
          const DialogLabel('Name'),
          const VBox(4),
          TextInputField(
            hint: 'Name',
            controller: state.nameController,
            onChanged: (_) => state.notify(),
            isForm: true,
            validator: (value) => value.isEmpty ? 'Name is required' : null,
          ),
          const VBox(16),
          const DialogLabel('Description'),
          const VBox(4),
          TextInputField(
            hint: 'Description',
            controller: state.descriptionController,
            onChanged: (_) => state.notify(),
            maxLines: 5,
            isForm: true,
          ),
          const VBox(16),
        ],
      ),
    );
  }
}

class CreateProjectDialogState extends BaseState {
  final GlobalKey<ShadFormState> formKey = GlobalKey();
  final CreateProjectCallback onCreateProject;
  final TextInputController nameController = TextInputController();
  final TextInputController descriptionController = TextInputController();

  CreateProjectDialogState({required this.onCreateProject});

  String get name => nameController.text.trim();

  String get description => descriptionController.text.trim();

  bool get formValid => formKey.currentState!.validate();

  void onCreate() => onCreateProject(
        name: name,
        description: description,
      );
}

typedef CreateProjectCallback = void Function({
  required String name,
  required String description,
});
