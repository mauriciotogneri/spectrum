import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:testflow/presentation/auth/sign_in_screen.dart';
import 'package:testflow/presentation/dashboard/dashboard_screen.dart';
import 'package:testflow/utils/navigation.dart';
import 'package:testflow/utils/palette.dart';

class TestFlow extends StatelessWidget {
  const TestFlow();

  @override
  Widget build(BuildContext context) {
    return ShadApp.material(
      debugShowCheckedModeBanner: false,
      title: 'TestFlow',
      navigatorKey: Navigation.getRoutes.key,
      navigatorObservers: [Navigation.getRoutes.routeObserver],
      materialThemeBuilder: (context, theme) {
        return theme.copyWith(
          colorScheme: ColorScheme.fromSeed(seedColor: Palette.primary),
        );
      },
      theme: ShadThemeData(
        brightness: Brightness.light,
        colorScheme: const ShadSlateColorScheme.light(
          primary: Palette.primary,
        ),
      ),
      home: kDebugMode ? DashboardScreen.instance() : SignInScreen.instance(),
    );
  }
}
