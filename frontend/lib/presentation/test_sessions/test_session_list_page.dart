import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:testflow/debug/data.dart';
import 'package:testflow/domain/model/test_session.dart';
import 'package:testflow/domain/state/test_sessions/test_session_list_state.dart';
import 'package:testflow/domain/types/test_session_status.dart';
import 'package:testflow/presentation/common/input/custom_dropdown_multiple.dart';
import 'package:testflow/presentation/common/input/custom_dropdown_single.dart';
import 'package:testflow/presentation/common/input/custom_text_input.dart';
import 'package:testflow/presentation/common/layout/pane.dart';
import 'package:testflow/presentation/common/navigation/navigation_path.dart';
import 'package:testflow/presentation/common/table/custom_table.dart';

class TestSessionListPage extends StatelessWidget {
  final TestSessionListState state;

  const TestSessionListPage._(this.state);

  factory TestSessionListPage.instance({required String projectId}) =>
      TestSessionListPage._(TestSessionListState(projectId: projectId));

  @override
  Widget build(BuildContext context) {
    return StateProvider<TestSessionListState>(
      state: state,
      builder:
          (context, state) => Pane.scrollable(
            children: [
              const PaneHeader(
                path: NavigationPath(paths: [PathItem(text: 'Sessions')]),
              ),
              Table(state),
            ],
          ),
    );
  }
}

class Table extends StatelessWidget {
  final TestSessionListState state;

  const Table(this.state);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: CustomTable<TestSession, TestSessionColumn, void>(
        columns: TestSession.columns,
        rows: state.testSessions,
        onSelected:
            (testSession) => state.onTestSessionSelected(
              context: context,
              testSessionId: testSession.id,
            ),
        onResetFilters: state.hasFilters ? state.onResetFilters : null,
        filters: [
          CustomTextInput(
            width: 250,
            hint: 'Filter…',
            canClear: true,
            prefixIcon: Icons.search,
            controller: state.queryFilterController,
            onChanged: (_) => state.notify(),
          ),
          const HBox(8),
          CustomDropdownMultiple<TestSessionStatus>(
            width: 200,
            values: TestSessionStatus.items,
            controller: state.statusFilterController,
            onSelected: (_) => state.notify(),
            hint: 'Status',
          ),
          const HBox(8),
          CustomDropdownMultiple<String>(
            width: 180,
            values: DropdownItem.fromList(Data.currentProject.environments),
            controller: state.environmentFilterController,
            onSelected: (_) => state.notify(),
            hint: 'Environment',
          ),
          const HBox(8),
          CustomDropdownMultiple<String>(
            width: 180,
            values: DropdownItem.fromList(Data.currentProject.platforms),
            controller: state.platformFilterController,
            onSelected: (_) => state.notify(),
            hint: 'Platform',
          ),
          const HBox(8),
          CustomDropdownMultiple<String>(
            width: 180,
            values: DropdownItem.fromList(Data.currentProject.devices),
            controller: state.deviceFilterController,
            onSelected: (_) => state.notify(),
            hint: 'Device',
          ),
        ],
      ),
    );
  }
}
