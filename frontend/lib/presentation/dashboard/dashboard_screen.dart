import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:testflow/domain/state/dashboard/dashboard_state.dart';

class DashboardScreen extends StatelessWidget {
  final DashboardState state;

  const DashboardScreen._(this.state);

  factory DashboardScreen.instance() => DashboardScreen._(DashboardState());

  @override
  Widget build(BuildContext context) {
    return StateProvider<DashboardState>(
      state: state,
      builder: (context, state) => Body(state),
    );
  }
}

class Body extends StatelessWidget {
  final DashboardState state;

  const Body(this.state);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Content(state),
      ),
    );
  }
}

class Content extends StatelessWidget {
  final DashboardState state;

  const Content(this.state);

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Dashboard'),
      ],
    );
  }
}
