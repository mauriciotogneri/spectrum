import 'package:flutter/material.dart';
import 'package:testflow/presentation/auth/sign_in_screen.dart';
import 'package:testflow/utils/navigation.dart';

class TestFlow extends StatelessWidget {
  const TestFlow();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TestFlow',
      navigatorKey: Navigation.getRoutes.key,
      navigatorObservers: [Navigation.getRoutes.routeObserver],
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: SignInScreen.instance(),
    );
  }
}
