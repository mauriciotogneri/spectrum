import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:testflow/presentation/common/button/primary_button.dart';
import 'package:testflow/presentation/common/button/secondary_button.dart';
import 'package:testflow/presentation/common/input/text_input_field.dart';
import 'package:testflow/utils/navigation.dart';

class CreateProjectDialog extends StatelessWidget {
  final Function({
    required String name,
    required String description,
  }) onCreate;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  CreateProjectDialog({
    required this.onCreate,
  });

  @override
  Widget build(BuildContext context) {
    return ShadDialog(
      title: const Text('New project'),
      actions: [
        const SecondaryButton(
          text: 'Cancel',
          onPressed: Navigation.pop,
        ),
        PrimaryButton(
          text: 'Create',
          onPressed: () {
            Navigation.pop();
            onCreate(
              name: nameController.text.trim(),
              description: descriptionController.text.trim(),
            );
          },
        ),
      ],
      child: Container(
        width: 375,
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextInputField(
              hint: 'Name',
              controller: nameController,
            ),
          ],
        ),
      ),
    );
  }
}
