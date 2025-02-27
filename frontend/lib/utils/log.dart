import 'dart:async';
import 'package:logger/logger.dart';
import 'package:testflow/utils/firebase_config.dart';

class Log {
  const Log._();

  static final Logger logger = Logger();

  static void trace(String type, String message) {
    logger.t('$type - $message');

    unawaited(FirebaseConfig.crashlytics().log('$type - $message'));
  }

  static void debug(dynamic message, [dynamic error, StackTrace? stackTrace]) =>
      logger.d(message, error: error, stackTrace: stackTrace);

  static void warning(
    dynamic message, [
    dynamic error,
    StackTrace? stackTrace,
  ]) => logger.w(message, error: error, stackTrace: stackTrace);

  static void error(dynamic message, [dynamic error, StackTrace? stackTrace]) =>
      logger.e(message, error: error, stackTrace: stackTrace);
}
