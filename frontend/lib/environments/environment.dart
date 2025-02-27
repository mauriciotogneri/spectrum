import 'package:flutter/foundation.dart';
import 'package:testflow/utils/locator.dart';

abstract class Environment {
  String get name;

  bool get isDebugMode => kDebugMode;

  bool get isReleaseMode => kReleaseMode;

  bool get showLogs => isDebugMode;

  bool get isLocal => name == 'local';

  bool get isRemote => name == 'remote';

  String get platform => defaultTargetPlatform.name;

  String get localhost => '10.0.2.2';

  Future configure() async {}

  static Environment get get => locator<Environment>();
}
