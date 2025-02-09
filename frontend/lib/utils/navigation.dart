import 'package:dafluta/dafluta.dart';
import 'package:flutter/widgets.dart';
import 'package:testflow/domain/events/stack_view_event.dart';
import 'package:testflow/domain/events/unstack_view_event.dart';
import 'package:testflow/presentation/auth/sign_in_screen.dart';
import 'package:testflow/presentation/dashboard/dashboard_screen.dart';
import 'package:testflow/utils/locator.dart';
import 'package:testflow/utils/log.dart';

class Navigation {
  final Routes routes = Routes();

  static Navigation get _get => locator<Navigation>();

  static Routes get getRoutes => _get.routes;

  static BuildContext get context => _get.routes.key.currentContext!;

  static bool get isOnlyRoute =>
      (_currentRoute?.isCurrent ?? false) && (_currentRoute?.isFirst ?? false);

  static Route<dynamic>? get _currentRoute => _get.routes.current();

  static void hideKeyboard() => Keyboard.hide(context);

  static bool isCurrent(String name) => _currentRoute?.settings.name == name;

  static Future<T?>? push<T>(Route<T> route) {
    final String? name = route.settings.name;

    if (name != null) {
      Log.trace('Navigation', 'Push: $name');
    }

    return _get.routes.push(route);
  }

  static Future<T?>? pushAlone<T>(Route<T> route) {
    final String? name = route.settings.name;

    if (name != null) {
      Log.trace('Navigation', 'Push alone: $name');
    }

    return _get.routes.pushAlone(route);
  }

  static Future<T?>? pushReplacement<T>(Route<T> route) {
    final String? name = route.settings.name;

    if (name != null) {
      Log.trace('Navigation', 'Push replacement: $name');
    }

    _get.routes.pushReplacement(route);
    return null;
  }

  static void pop<T>([T? result]) {
    Log.trace('Navigation', 'Pop: ${_currentRoute?.settings.name}');

    return _get.routes.pop(result);
  }

  static void popUntil(RoutePredicate predicate) =>
      _get.routes.popUntil(predicate);

  static void stack(Widget view) => StackViewEvent(view).dispatch();

  static void unstack() => const UnstackViewEvent().dispatch();

  static void dialog(String name, Widget widget) => push(
        PageRouteBuilder(
          opaque: false,
          pageBuilder: (context, _, __) => widget,
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
          settings: RouteSettings(name: name),
        ),
      );

  // ================================ AUTH ================================== \\

  static void signInScreen() => pushAlone(
        FadeRoute(
          SignInScreen.instance(),
          name: 'sign_in',
        ),
      );

  // ============================= DASHBOARD ================================ \\

  static void dashboardScreen() => pushAlone(
        BasicRoute(
          DashboardScreen.instance(),
          name: 'dashboard  ',
        ),
      );
}
