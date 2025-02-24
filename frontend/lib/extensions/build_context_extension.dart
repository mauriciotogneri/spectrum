import 'package:flutter/widgets.dart';
import 'package:testflow/utils/navigation.dart';

extension BuildContextExtension on BuildContext {
  // =============================== SIGN IN ================================ \\

  void signIn() => Navigation.go(context: this, path: Navigation.signInPath());

  // ================================= MENU ================================= \\

  void dashboard({required String projectId}) => Navigation.go(
    context: this,
    path: Navigation.dashboardPath(projectId: projectId),
  );

  void requirementList({required String projectId}) => Navigation.go(
    context: this,
    path: Navigation.requirementListPath(projectId: projectId),
  );

  void testSuiteList({required String projectId}) => Navigation.go(
    context: this,
    path: Navigation.testSuiteListPath(projectId: projectId),
  );

  void testSessionList({required String projectId}) => Navigation.go(
    context: this,
    path: Navigation.testSessionListPath(projectId: projectId),
  );

  void settings({required String projectId}) => Navigation.go(
    context: this,
    path: Navigation.settingsPath(projectId: projectId),
  );

  void components({required String projectId}) => Navigation.go(
    context: this,
    path: Navigation.componentsPath(projectId: projectId),
  );

  // ============================= REQUIREMENT ============================== \\

  void requirementDetail({
    required String projectId,
    required String requirementId,
  }) => Navigation.go(
    context: this,
    path: Navigation.requirementDetailPath(
      projectId: projectId,
      requirementId: requirementId,
    ),
  );

  // ============================== TEST CASE =============================== \\

  void testCaseDetail({
    required String projectId,
    required String requirementId,
    required String testCaseId,
  }) => Navigation.go(
    context: this,
    path: Navigation.testCaseDetailPath(
      projectId: projectId,
      requirementId: requirementId,
      testCaseId: testCaseId,
    ),
  );

  // ============================= TEST SUITES ============================== \\

  void testSuiteDetail({
    required String projectId,
    required String testSuiteId,
  }) => Navigation.go(
    context: this,
    path: Navigation.testSuiteDetailPath(
      projectId: projectId,
      testSuiteId: testSuiteId,
    ),
  );

  // =========================== TEST SESSIONS ============================== \\

  void testSessionDetail({
    required String projectId,
    required String testSessionId,
  }) => Navigation.go(
    context: this,
    path: Navigation.testSessionDetailPath(
      projectId: projectId,
      testSessionId: testSessionId,
    ),
  );
}
