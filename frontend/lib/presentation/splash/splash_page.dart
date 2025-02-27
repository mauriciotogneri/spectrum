import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:testflow/domain/state/splash/splash_state.dart';

class SplashPage extends StatelessWidget {
  final SplashState state;

  const SplashPage._(this.state);

  factory SplashPage.instance() => SplashPage._(SplashState());

  @override
  Widget build(BuildContext context) {
    return StateProvider<SplashState>(
      state: state,
      builder: (context, state) => const Scaffold(body: Empty()),
    );
  }
}
