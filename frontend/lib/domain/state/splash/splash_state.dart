import 'package:dafluta/dafluta.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashState extends BaseState {
  void init(BuildContext context) {
    if (kDebugMode) {
      Delayed.post(() => context.go('/projects/1/dashboard'));
    } else {
      Delayed.post(() => context.go('/sign-in'));
    }
  }
}
