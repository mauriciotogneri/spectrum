import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:testflow/debug/data.dart';
import 'package:testflow/domain/model/test_session.dart';
import 'package:testflow/domain/types/test_session_status.dart';
import 'package:testflow/presentation/common/input/custom_dropdown_multiple.dart';
import 'package:testflow/presentation/common/input/custom_text_input.dart';

class TestSessionListState extends BaseState {
  final String projectId;
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

  TestSessionListState({required this.projectId});

  List<TestSession> get testSessions =>
      Data.testSessions()
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

  void onTestSessionSelected({
    required BuildContext context,
    required String testSessionId,
  }) {} /*=> context.testSessionDetail(
    projectId: projectId,
    testSessionId: testSessionId,
  );*/
}
