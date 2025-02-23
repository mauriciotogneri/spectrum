import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:testflow/debug/data.dart';
import 'package:testflow/domain/model/requirement.dart';
import 'package:testflow/domain/model/test_case.dart';
import 'package:testflow/domain/model/test_run.dart';
import 'package:testflow/domain/types/test_case_execution.dart';
import 'package:testflow/domain/types/test_run_reproducibility.dart';
import 'package:testflow/domain/types/test_run_result.dart';
import 'package:testflow/presentation/common/form/form_key.dart';
import 'package:testflow/presentation/common/input/custom_dropdown_multiple.dart';
import 'package:testflow/presentation/common/input/custom_dropdown_single.dart';
import 'package:testflow/presentation/common/input/custom_text_input.dart';
import 'package:testflow/presentation/dialogs/base_dialog.dart';
import 'package:testflow/presentation/dialogs/confirmation_dialog.dart';
import 'package:testflow/utils/palette.dart';

class TestCaseDetailState extends BaseState {
  final String projectId;
  final String requirementId;
  final String testCaseId;
  Requirement? _requirement;
  TestCase? _testCase;
  final FormKey formKey = FormKey();
  final CustomTextInputController nameController = CustomTextInputController();
  final CustomDropdownSingleController<TestCaseExecution> executionController =
      CustomDropdownSingleController();
  final CustomTextInputController preconditionsController =
      CustomTextInputController();
  final CustomTextInputController stepsController = CustomTextInputController();
  final CustomTextInputController expectedController =
      CustomTextInputController();

  final CustomTextInputController queryFilterController =
      CustomTextInputController();
  final CustomDropdownMultipleController<TestRunResult> resultFilterController =
      CustomDropdownMultipleController();
  final CustomDropdownMultipleController<TestRunReproducibility>
  reproducibilityFilterController = CustomDropdownMultipleController();

  TestCaseDetailState({
    required this.projectId,
    required this.requirementId,
    required this.testCaseId,
  });

  List<TestRun> get testRuns =>
      Data.testRuns(testCase)
          .where(
            (testRun) => testRun.matches(
              queryFilter: queryFilterController.text,
              resultFilter: resultFilterController.selected,
              reproducibilityFilter: reproducibilityFilterController.selected,
            ),
          )
          .toList();

  Requirement get requirement => _requirement!;

  TestCase get testCase => _testCase!;

  bool get isLoading => (_requirement == null) || (_testCase == null);

  bool get hasFilters =>
      queryFilterController.isNotEmpty ||
      resultFilterController.isNotEmpty ||
      reproducibilityFilterController.isNotEmpty;

  @override
  void onLoad() {
    _requirement = Data.requirementById(requirementId);
    _testCase = Data.testCaseById(testCaseId);

    nameController.text = testCase.name;
    executionController.select(testCase.execution);
    preconditionsController.text = testCase.preconditions;
    stepsController.text = testCase.steps;
    expectedController.text = testCase.expected;

    notify();
  }

  void onResetFilters() {
    queryFilterController.clear();
    resultFilterController.clear();
    reproducibilityFilterController.clear();
    notify();
  }

  void onTestRunSelected({
    required BuildContext context,
    required TestRun testRun,
  }) {}

  void onQuickTest() {}

  void onDeleteTestCase(BuildContext context) => BaseDialog.show(
    context: context,
    dialog: ConfirmationDialog(
      message: 'Do you want to delete the test case?',
      acceptButtonText: 'Delete',
      acceptButtonColor: Palette.borderButtonError,
      onAccept: () => _deleteTestCase(context: context, testCase: testCase),
    ),
  );

  void _deleteTestCase({
    required BuildContext context,
    required TestCase testCase,
  }) {
    Data.deleteTestCase(testCase);
    Navigator.of(context).pop();
  }
}
