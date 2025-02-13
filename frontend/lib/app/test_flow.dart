import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:testflow/presentation/auth/sign_in_screen.dart';
import 'package:testflow/presentation/dashboard/dashboard_screen.dart';
import 'package:testflow/utils/navigation.dart';
import 'package:testflow/utils/palette.dart';

class TestFlow extends StatelessWidget {
  const TestFlow();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TestFlow',
      navigatorKey: Navigation.getRoutes.key,
      navigatorObservers: [Navigation.getRoutes.routeObserver],
      theme: ThemeData(colorSchemeSeed: Palette.primary, useMaterial3: true),
      home: kDebugMode ? DashboardScreen.instance() : SignInScreen.instance(),
    );
  }
}
