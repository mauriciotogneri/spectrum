import 'dart:async';
import 'package:testflow/utils/log.dart';

class ErrorHandler {
  static void trace(Object exception) {
    _logError(
      exception.toString(),
      exception,
      null,
    );

    /*unawaited(FirebaseConfig.crashlytics().recordError(
      exception,
      null,
      reason: type.name,
      fatal: false,
    ));*/
  }

  static Future onUncaughtError(Object exception, StackTrace stackTrace) {
    _logError(
      'Uncaught Error',
      exception,
      stackTrace,
    );

    /*return FirebaseConfig.crashlytics().recordError(
      exception,
      stackTrace,
      fatal: true,
    );*/

    return Future.value();
  }

  static void _logError(
    String message,
    dynamic error,
    StackTrace? stackTrace,
  ) {
    try {
      Log.error(message, error, stackTrace);
      Log.trace('ErrorHandler', '$message $error $stackTrace');
    } catch (e) {
      Log.warning('Cannot log error: $error', e);
    }
  }

  static void setup() {
    /*FlutterError.onError = (details) {
      if (!isUiError(details)) {
        FirebaseConfig.crashlytics().recordFlutterError(details);
      }
    };

    PlatformDispatcher.instance.onError = (error, stack) {
      onUncaughtError(error, stack);
      return true;
    };

    Isolate.current.addErrorListener(RawReceivePort((pair) async {
      final List<dynamic> errorAndStacktrace = pair;
      await FirebaseConfig.crashlytics().recordError(
        errorAndStacktrace.first,
        errorAndStacktrace.last,
        fatal: true,
      );
    }).sendPort);*/
  }
}
