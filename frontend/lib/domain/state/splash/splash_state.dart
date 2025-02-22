import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:testflow/debug/data.dart';
import 'package:testflow/utils/navigation.dart';
import 'package:testflow/utils/platform.dart';

class SplashState extends BaseState {
  void init(BuildContext context) {
    if (Platform.isDebug) {
      Delayed.post(
        () => Navigation.dashboard(
          context: context,
          projectId: Data.currentProject.id,
        ),
      );
    } else {
      Delayed.post(() => Navigation.signIn(context));
    }
  }
}
