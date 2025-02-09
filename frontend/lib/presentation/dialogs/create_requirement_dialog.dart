import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:testflow/presentation/common/button/primary_button.dart';
import 'package:testflow/presentation/common/button/secondary_button.dart';
import 'package:testflow/presentation/common/input/text_input_field.dart';
import 'package:testflow/presentation/dialogs/base_dialog.dart';
import 'package:testflow/utils/navigation.dart';
import 'package:testflow/utils/palette.dart';

class CreateRequirementDialog extends StatelessWidget {
  final CreateRequirementDialogState state;

  const CreateRequirementDialog._(this.state);

  factory CreateRequirementDialog.instance({
    required CreateRequirementCallback onCreateRequirement,
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
            enabled: state.formFilled,
            onPressed: () {
              Navigation.pop();
              state.onCreate();
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
          const VBox(16),
          const Padding(
            padding: EdgeInsets.only(left: 6),
            child: Text(
              'Name',
              style: TextStyle(
                color: Palette.textEnabled,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const VBox(4),
          TextInputField(
            hint: 'Name',
            controller: state.nameController,
            onChanged: (_) => state.notify(),
          ),
          const VBox(16),
          const Padding(
            padding: EdgeInsets.only(left: 6),
            child: Text(
              'Description',
              style: TextStyle(
                color: Palette.textEnabled,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const VBox(4),
          TextInputField(
            hint: 'Description',
            controller: state.descriptionController,
            onChanged: (_) => state.notify(),
            maxLines: 5,
          ),
          const VBox(16),
        ],
      ),
    );
  }
}

class CreateRequirementDialogState extends BaseState {
  final GlobalKey<ShadFormState> formKey = GlobalKey();
  final CreateRequirementCallback onCreateRequirement;
  final TextInputController nameController = TextInputController();
  final TextInputController descriptionController = TextInputController();

  CreateRequirementDialogState({required this.onCreateRequirement});

  String get name => nameController.text.trim();

  String get description => descriptionController.text.trim();

  bool get formFilled => name.isNotEmpty && description.isNotEmpty;

  void onCreate() => onCreateRequirement(
        name: name,
        description: description,
      );
}

typedef CreateRequirementCallback = void Function({
  required String name,
  required String description,
});
