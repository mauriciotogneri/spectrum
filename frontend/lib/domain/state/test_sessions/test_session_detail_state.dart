import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:testflow/debug/data.dart';
import 'package:testflow/domain/model/test_run.dart';
import 'package:testflow/domain/model/test_session.dart';
import 'package:testflow/domain/types/test_run_reproducibility.dart';
import 'package:testflow/domain/types/test_run_result.dart';
import 'package:testflow/presentation/common/form/form_key.dart';
import 'package:testflow/presentation/common/input/custom_dropdown_multiple.dart';
import 'package:testflow/presentation/common/input/custom_dropdown_single.dart';
import 'package:testflow/presentation/common/input/custom_text_input.dart';
import 'package:testflow/presentation/dialogs/base_dialog.dart';
import 'package:testflow/presentation/dialogs/confirmation_dialog.dart';
import 'package:testflow/utils/palette.dart';

class TestSessionDetailState extends BaseState {
  final String projectId;
  final String testSessionId;
  TestSession? _testSession;
  final FormKey formKey = FormKey();
  final CustomTextInputController nameController = CustomTextInputController();
  final CustomDropdownSingleController<String> environmentController =
      CustomDropdownSingleController();
  final CustomDropdownSingleController<String> platformController =
      CustomDropdownSingleController();
  final CustomDropdownSingleController<String> deviceController =
      CustomDropdownSingleController();
  final CustomTextInputController versionController =
      CustomTextInputController();

  final CustomTextInputController queryFilterController =
      CustomTextInputController();
  final CustomDropdownMultipleController<TestRunResult> resultFilterController =
      CustomDropdownMultipleController();
  final CustomDropdownMultipleController<TestRunReproducibility>
  reproducibilityFilterController = CustomDropdownMultipleController();

  TestSessionDetailState({
    required this.projectId,
    required this.testSessionId,
  });

  List<TestRun> get testRuns =>
      Data.testRunsByTestSession(testSession)
          .where(
            (testRun) => testRun.matches(
              queryFilter: queryFilterController.text,
              resultFilter: resultFilterController.selected,
              reproducibilityFilter: reproducibilityFilterController.selected,
            ),
          )
          .toList();

  TestSession get testSession => _testSession!;

  bool get isLoading => _testSession == null;

  bool get hasFilters =>
      queryFilterController.isNotEmpty ||
      resultFilterController.isNotEmpty ||
      reproducibilityFilterController.isNotEmpty;

  @override
  void onLoad() {
    _testSession = Data.testSessionById(testSessionId);

    nameController.text = testSession.name;
    environmentController.select(testSession.environment);
    platformController.select(testSession.platform);
    deviceController.select(testSession.device);
    versionController.text = testSession.version;
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

  void onDeleteTestSession(BuildContext context) => BaseDialog.show(
    context: context,
    dialog: ConfirmationDialog(
      message: 'Do you want to delete the session?',
      acceptButtonText: 'Delete',
      acceptButtonColor: Palette.borderButtonError,
      onAccept:
          () => _deleteTestSession(context: context, testSession: testSession),
    ),
  );

  void _deleteTestSession({
    required BuildContext context,
    required TestSession testSession,
  }) {
    Data.deleteTestSession(testSession);
    Navigator.of(context).pop();
  }
}
