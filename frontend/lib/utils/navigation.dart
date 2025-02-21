import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:testflow/presentation/auth/sign_in_page.dart';
import 'package:testflow/presentation/components/components_view.dart';
import 'package:testflow/presentation/dashboard/dashboard_view.dart';
import 'package:testflow/presentation/navigation/navigation_menu.dart';
import 'package:testflow/presentation/requirements/requirements_list_view.dart';
import 'package:testflow/presentation/splash/splash_page.dart';

class Navigation {
  static final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey(
    debugLabel: 'root',
  );
  static final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey(
    debugLabel: 'shell',
  );

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
            builder: (context, state) => DashboardView.instance(),
          ),
          GoRoute(
            path: '/projects/:projectId/requirements',
            builder: (context, state) => RequirementsListView.instance(),
          ),
          GoRoute(
            path: '/projects/:projectId/components',
            builder: (context, state) => ComponentsView.instance(),
          ),
        ],
      ),
    ],
  );
}
