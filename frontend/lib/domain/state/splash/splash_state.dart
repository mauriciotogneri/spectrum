import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:testflow/debug/data.dart';
import 'package:testflow/extensions/build_context_extension.dart';
import 'package:testflow/utils/platform.dart';

class SplashState extends BaseState {
  void init(BuildContext context) {
    if (Platform.isDebug) {
      Delayed.post(() => context.dashboard(projectId: Data.currentProject.id));
    } else {
      Delayed.post(() => context.signIn());
    }
  }
}
