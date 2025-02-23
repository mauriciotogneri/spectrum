import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:testflow/debug/data.dart';
import 'package:testflow/domain/model/suite.dart';
import 'package:testflow/domain/types/requirement_importance.dart';
import 'package:testflow/domain/types/requirement_type.dart';
import 'package:testflow/presentation/common/form/form_key.dart';
import 'package:testflow/presentation/common/input/custom_dropdown_multiple.dart';
import 'package:testflow/presentation/common/input/custom_text_input.dart';
import 'package:testflow/presentation/dialogs/base_dialog.dart';
import 'package:testflow/presentation/dialogs/confirmation_dialog.dart';
import 'package:testflow/utils/palette.dart';

class SuiteDetailState extends BaseState {
  final String projectId;
  final String suiteId;
  Suite? _suite;
  final FormKey formKey = FormKey();
  final CustomTextInputController nameController = CustomTextInputController();
  final CustomDropdownMultipleController<RequirementType> typeController =
      CustomDropdownMultipleController();
  final CustomDropdownMultipleController<RequirementImportance>
  importanceController = CustomDropdownMultipleController();
  final CustomDropdownMultipleController<String> componentController =
      CustomDropdownMultipleController();
  final CustomDropdownMultipleController<String> platformsController =
      CustomDropdownMultipleController();

  SuiteDetailState({required this.projectId, required this.suiteId});

  Suite get suite => _suite!;

  bool get isLoading => _suite == null;

  @override
  void onLoad() {
    _suite = Data.suiteById(suiteId);

    nameController.text = suite.name;
    typeController.select(suite.types);
    importanceController.select(suite.importances);
    componentController.select(suite.components);
    platformsController.select(suite.platforms);
    notify();
  }

  void onStartSession() {}

  void onDeleteSuite(BuildContext context) => BaseDialog.show(
    context: context,
    dialog: ConfirmationDialog(
      message: 'Do you want to delete the test suite?',
      acceptButtonText: 'Delete',
      acceptButtonColor: Palette.borderButtonError,
      onAccept: () => _deleteSuite(context: context, suite: suite),
    ),
  );

  void _deleteSuite({required BuildContext context, required Suite suite}) {
    Data.deleteSuite(suite);
    Navigator.of(context).pop();
  }
}
