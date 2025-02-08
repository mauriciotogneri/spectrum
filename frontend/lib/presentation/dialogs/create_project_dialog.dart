import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:testflow/presentation/common/button/primary_button.dart';
import 'package:testflow/presentation/common/button/secondary_button.dart';
import 'package:testflow/presentation/common/input/text_input_field.dart';
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
      builder: (context, state) => ShadDialog(
        title: const Padding(
          padding: EdgeInsets.only(left: 4),
          child: Text('New project'),
        ),
        actions: [
          const SecondaryButton(
            text: 'Cancel',
            onPressed: Navigation.pop,
          ),
          PrimaryButton(
            text: 'Create',
            enabled: state.formFilled,
            onPressed: () {
              Navigation.pop();
              state.onCreate();
            },
          ),
        ],
        child: SizedBox(
          width: 350,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextInputField(
                hint: 'Name',
                controller: state.nameController,
                onChanged: (_) => state.notify(),
              ),
              TextInputField(
                hint: 'Description',
                controller: state.descriptionController,
                onChanged: (_) => state.notify(),
                maxLines: 5,
              ),
              const VBox(16),
            ],
          ),
        ),
      ),
    );
  }
}

class CreateProjectDialogState extends BaseState {
  final CreateProjectCallback onCreateProject;
  final TextInputController nameController = TextInputController();
  final TextInputController descriptionController = TextInputController();

  CreateProjectDialogState({required this.onCreateProject});

  String get name => nameController.text.trim();

  String get description => descriptionController.text.trim();

  bool get formFilled => name.isNotEmpty && description.isNotEmpty;

  void onCreate() => onCreateProject(
        name: name,
        description: description,
      );
}

typedef CreateProjectCallback = void Function({
  required String name,
  required String description,
});
