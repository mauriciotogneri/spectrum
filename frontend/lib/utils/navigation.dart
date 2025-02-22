import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:testflow/extensions/go_router_state_extension.dart';
import 'package:testflow/presentation/auth/sign_in_page.dart';
import 'package:testflow/presentation/components/components_page.dart';
import 'package:testflow/presentation/dashboard/dashboard_page.dart';
import 'package:testflow/presentation/navigation/navigation_menu.dart';
import 'package:testflow/presentation/requirements/requirement_detail_page.dart';
import 'package:testflow/presentation/requirements/requirement_list_page.dart';
import 'package:testflow/presentation/sessions/session_list_page.dart';
import 'package:testflow/presentation/settings/settings_page.dart';
import 'package:testflow/presentation/splash/splash_page.dart';
import 'package:testflow/presentation/suites/suite_detail_page.dart';
import 'package:testflow/presentation/suites/suite_list_page.dart';
import 'package:testflow/presentation/test_cases/test_case_detail_page.dart';

class Navigation {
  static final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey();
  static final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey();

  static GoRouter get router => GoRouter(
    navigatorKey: _rootNavigatorKey,
    routes: [
      GoRoute(path: '/', builder: (context, state) => SplashPage.instance()),
      GoRoute(
        path: '/sign-in',
        builder: (context, state) => SignInPage.instance(),
      ),
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) => NavigationMenu(child: child),
        routes: [
          GoRoute(
            path: '/projects/:projectId/dashboard',
            builder: (context, state) => DashboardPage.instance(),
          ),
          GoRoute(
            path: '/projects/:projectId/requirements',
            builder:
                (context, state) => RequirementListPage.instance(
                  projectId: state.param('projectId'),
                ),
            routes: [
              GoRoute(
                path: ':requirementId',
                builder:
                    (context, state) => RequirementDetailPage.instance(
                      projectId: state.param('projectId'),
                      requirementId: state.param('requirementId'),
                    ),
                routes: [
                  GoRoute(
                    path: 'cases/:testCaseId',
                    builder:
                        (context, state) => TestCaseDetailPage.instance(
                          projectId: state.param('projectId'),
                          requirementId: state.param('requirementId'),
                          testCaseId: state.param('testCaseId'),
                        ),
                  ),
                ],
              ),
            ],
          ),
          GoRoute(
            path: '/projects/:projectId/suites',
            builder:
                (context, state) =>
                    SuiteListPage.instance(projectId: state.param('projectId')),
            routes: [
              GoRoute(
                path: ':suiteId',
                builder:
                    (context, state) => SuiteDetailPage.instance(
                      projectId: state.param('projectId'),
                      suiteId: state.param('suiteId'),
                    ),
              ),
            ],
          ),
          GoRoute(
            path: '/projects/:projectId/sessions',
            builder: (context, state) => SessionListPage.instance(),
          ),
          GoRoute(
            path: '/projects/:projectId/settings',
            builder: (context, state) => SettingsPage.instance(),
          ),
          GoRoute(
            path: '/projects/:projectId/components',
            builder: (context, state) => ComponentsPage.instance(),
          ),
        ],
      ),
    ],
  );

  static String location(BuildContext context) =>
      GoRouter.of(context).routerDelegate.currentConfiguration.uri.toString();

  static void go({required BuildContext context, required String path}) =>
      context.go(path);

  static void push({required BuildContext context, required String path}) =>
      context.push(path);

  // =============================== SIGN IN ================================ \\

  static String signInPath() => '/sign-in';

  // ================================= MENU ================================= \\

  static String dashboardPath({required String projectId}) =>
      '/projects/$projectId/dashboard';

  static String requirementListPath({required String projectId}) =>
      '/projects/$projectId/requirements';

  static String suiteListPath({required String projectId}) =>
      '/projects/$projectId/suites';

  static String sessionListPath({required String projectId}) =>
      '/projects/$projectId/sessions';

  static String settingsPath({required String projectId}) =>
      '/projects/$projectId/settings';

  static String componentsPath({required String projectId}) =>
      '/projects/$projectId/components';

  // ============================= REQUIREMENT ============================== \\

  static String requirementDetailPath({
    required String projectId,
    required String requirementId,
  }) => '/projects/$projectId/requirements/$requirementId';

  // ============================== TEST CASE =============================== \\

  static String testCaseDetailPath({
    required String projectId,
    required String requirementId,
    required String testCaseId,
  }) => '/projects/$projectId/requirements/$requirementId/cases/$testCaseId';

  // ================================ SUITE ================================= \\

  static String suiteDetailPath({
    required String projectId,
    required String suiteId,
  }) => '/projects/$projectId/suites/$suiteId';
}
