import 'dart:async';
import 'package:flutter/material.dart';
import 'package:testflow/app/test_flow.dart';
import 'package:testflow/environments/environment.dart';
import 'package:testflow/environments/environment_local.dart';
import 'package:testflow/environments/environment_remote.dart';
import 'package:testflow/utils/error_handler.dart';
import 'package:testflow/utils/locator.dart';
import 'package:testflow/utils/platform.dart';

void main() {
  runZonedGuarded(() async {
    await Locator.initialize(getEnvironment());
    runApp(const TestFlow());
  }, ErrorHandler.onUncaughtError);
}

Environment getEnvironment() {
  if (Platform.isDebug) {
    return LocalEnvironment();
  } else {
    return RemoteEnvironment();
  }
}
