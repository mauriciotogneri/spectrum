import 'dart:async';
import 'package:flutter/material.dart';
import 'package:testflow/app/test_flow.dart';
import 'package:testflow/utils/error_handler.dart';
import 'package:testflow/utils/locator.dart';

void main() {
  runZonedGuarded(() async {
    await Locator.initialize();
    runApp(const TestFlow());
  }, ErrorHandler.onUncaughtError);
}
