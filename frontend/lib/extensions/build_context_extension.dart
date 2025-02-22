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

  void suiteList({required String projectId}) => Navigation.go(
    context: this,
    path: Navigation.suiteListPath(projectId: projectId),
  );

  void sessionList({required String projectId}) => Navigation.go(
    context: this,
    path: Navigation.sessionListPath(projectId: projectId),
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

  // ================================ SUITE ================================= \\

  void suiteDetail({required String projectId, required String suiteId}) =>
      Navigation.go(
        context: this,
        path: Navigation.suiteDetailPath(
          projectId: projectId,
          suiteId: suiteId,
        ),
      );
}
