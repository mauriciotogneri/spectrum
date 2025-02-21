import 'package:flutter/material.dart';
import 'package:testflow/utils/navigation.dart';
import 'package:testflow/utils/style.dart';

class TestFlow extends StatelessWidget {
  const TestFlow();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'TestFlow',
      theme: Style.themeData,
      routerConfig: Navigation.router,
    );
  }
}
