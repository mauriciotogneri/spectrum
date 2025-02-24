import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:testflow/debug/data.dart';
import 'package:testflow/domain/model/test_session.dart';
import 'package:testflow/domain/model/test_suite.dart';
import 'package:testflow/domain/types/requirement_importance.dart';
import 'package:testflow/domain/types/requirement_type.dart';
import 'package:testflow/domain/types/test_session_status.dart';
import 'package:testflow/extensions/build_context_extension.dart';
import 'package:testflow/presentation/common/form/form_key.dart';
import 'package:testflow/presentation/common/input/custom_dropdown_multiple.dart';
import 'package:testflow/presentation/common/input/custom_text_input.dart';
import 'package:testflow/presentation/dialogs/base_dialog.dart';
import 'package:testflow/presentation/dialogs/confirmation_dialog.dart';
import 'package:testflow/utils/palette.dart';

class TestSuiteDetailState extends BaseState {
  final String projectId;
  final String testSuiteId;
  TestSuite? _testSuite;
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

  final CustomTextInputController queryFilterController =
      CustomTextInputController();
  final CustomDropdownMultipleController<TestSessionStatus>
  statusFilterController = CustomDropdownMultipleController();
  final CustomDropdownMultipleController<String> environmentFilterController =
      CustomDropdownMultipleController();
  final CustomDropdownMultipleController<String> platformFilterController =
      CustomDropdownMultipleController();
  final CustomDropdownMultipleController<String> deviceFilterController =
      CustomDropdownMultipleController();
  final CustomDropdownMultipleController<String> versionFilterController =
      CustomDropdownMultipleController();

  TestSuiteDetailState({required this.projectId, required this.testSuiteId});

  List<TestSession> get testSessions =>
      Data.testSessionsByTestSuite(testSuite)
          .where(
            (testSession) => testSession.matches(
              queryFilter: queryFilterController.text,
              statusFilter: statusFilterController.selected,
              environmentFilter: environmentFilterController.selected,
              platformFilter: platformFilterController.selected,
              deviceFilter: deviceFilterController.selected,
              versionFilter: versionFilterController.selected,
            ),
          )
          .toList();

  bool get hasFilters =>
      queryFilterController.isNotEmpty ||
      statusFilterController.isNotEmpty ||
      environmentFilterController.isNotEmpty ||
      platformFilterController.isNotEmpty ||
      deviceFilterController.isNotEmpty ||
      versionFilterController.isNotEmpty;

  void onResetFilters() {
    queryFilterController.clear();
    statusFilterController.clear();
    environmentFilterController.clear();
    platformFilterController.clear();
    deviceFilterController.clear();
    versionFilterController.clear();
    notify();
  }

  TestSuite get testSuite => _testSuite!;

  bool get isLoading => _testSuite == null;

  @override
  void onLoad() {
    _testSuite = Data.testSuiteById(testSuiteId);

    nameController.text = testSuite.name;
    typeController.select(testSuite.types);
    importanceController.select(testSuite.importances);
    componentController.select(testSuite.components);
    platformsController.select(testSuite.platforms);
    notify();
  }

  void onStartSession() {}

  void onDeleteTestSuite(BuildContext context) => BaseDialog.show(
    context: context,
    dialog: ConfirmationDialog(
      message: 'Do you want to delete the suite?',
      acceptButtonText: 'Delete',
      acceptButtonColor: Palette.borderButtonError,
      onAccept: () => _deleteTestSuite(context: context, testSuite: testSuite),
    ),
  );

  void _deleteTestSuite({
    required BuildContext context,
    required TestSuite testSuite,
  }) {
    Data.deleteTestSuite(testSuite);
    Navigator.of(context).pop();
  }

  void onTestSessionSelected({
    required BuildContext context,
    required String testSessionId,
  }) => context.testSessionDetail(
    projectId: projectId,
    testSessionId: testSessionId,
  );
}
