import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:testflow/domain/state/dashboard/dashboard_state.dart';
import 'package:testflow/presentation/common/layout/pane.dart';
import 'package:testflow/presentation/common/navigation/navigation_path.dart';
import 'package:testflow/presentation/common/text/body_medium.dart';

class DashboardPage extends StatelessWidget {
  final DashboardState state;

  const DashboardPage._(this.state);

  factory DashboardPage.instance() => DashboardPage._(DashboardState());

  @override
  Widget build(BuildContext context) {
    return StateProvider<DashboardState>(
      state: state,
      builder:
          (context, state) => Pane.scrollable(
            children: [
              const PaneHeader(
                path: NavigationPath(paths: [PathItem(text: 'Dashboard')]),
              ),
              Content(),
            ],
          ),
    );
  }
}

class Content extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          BodyMedium(text: '• Coverage %'),
          BodyMedium(text: '• Success/Failure rate'),
          BodyMedium(text: '• Current test failing'),
          BodyMedium(text: '• Most failures'),
          BodyMedium(text: '• Slowest tests'),
          BodyMedium(text: '• Most flaky tests'),
        ],
      ),
    );
  }
}
