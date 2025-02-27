import 'dart:async';
import 'dart:ui';
import 'package:flutter/widgets.dart';
import 'package:testflow/utils/firebase_config.dart';
import 'package:testflow/utils/log.dart';

class ErrorHandler {
  static void handle(Object exception) {
    _logError(exception.toString(), exception, null);

    unawaited(
      FirebaseConfig.crashlytics().recordError(
        exception,
        null,
        reason: exception,
        fatal: false,
      ),
    );
  }

  static Future onUncaughtError(Object exception, StackTrace stackTrace) {
    _logError('Uncaught Error', exception, stackTrace);

    return FirebaseConfig.crashlytics().recordError(
      exception,
      stackTrace,
      fatal: true,
    );
  }

  static void _logError(String message, dynamic error, StackTrace? stackTrace) {
    try {
      Log.error(message, error, stackTrace);
      Log.trace('ErrorHandler', '$message $error $stackTrace');
    } catch (e) {
      Log.warning('Cannot log error: $error', e);
    }
  }

  static void setup() {
    FlutterError.onError = FirebaseConfig.crashlytics().recordFlutterError;

    PlatformDispatcher.instance.onError = (error, stack) {
      onUncaughtError(error, stack);
      return true;
    };
  }
}
