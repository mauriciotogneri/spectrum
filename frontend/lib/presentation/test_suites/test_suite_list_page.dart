import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:testflow/debug/data.dart';
import 'package:testflow/domain/model/test_suite.dart';
import 'package:testflow/domain/state/test_suites/test_suite_list_state.dart';
import 'package:testflow/domain/types/requirement_importance.dart';
import 'package:testflow/domain/types/requirement_type.dart';
import 'package:testflow/presentation/common/input/custom_dropdown_multiple.dart';
import 'package:testflow/presentation/common/input/custom_dropdown_single.dart';
import 'package:testflow/presentation/common/input/custom_text_input.dart';
import 'package:testflow/presentation/common/layout/pane.dart';
import 'package:testflow/presentation/common/navigation/navigation_path.dart';
import 'package:testflow/presentation/common/table/custom_table.dart';

class TestSuiteListPage extends StatelessWidget {
  final TestSuiteListState state;

  const TestSuiteListPage._(this.state);

  factory TestSuiteListPage.instance({required String projectId}) =>
      TestSuiteListPage._(TestSuiteListState(projectId: projectId));

  @override
  Widget build(BuildContext context) {
    return StateProvider<TestSuiteListState>(
      state: state,
      builder:
          (context, state) => Pane.scrollable(
            children: [
              const PaneHeader(
                path: NavigationPath(paths: [PathItem(text: 'Suites')]),
              ),
              Table(state),
            ],
          ),
    );
  }
}

class Table extends StatelessWidget {
  final TestSuiteListState state;

  const Table(this.state);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: CustomTable<TestSuite, TestSuiteColumn, TestSuiteMenu>(
        columns: TestSuite.columns,
        rows: state.testSuites,
        onSelected:
            (testSuite) => state.onTestSuiteSelected(
              context: context,
              testSuiteId: testSuite.id,
            ),
        onResetFilters: state.hasFilters ? state.onResetFilters : null,
        onCreateItem: () => state.onCreateTestSuite(context),
        onMenuSelected:
            (item, menu) => state.onTableMenuSelected(
              context: context,
              testSuite: item,
              menu: menu,
            ),
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
          CustomDropdownMultiple<String>(
            width: 180,
            values: DropdownItem.fromList(Data.currentProject.components),
            controller: state.componentFilterController,
            onSelected: (_) => state.notify(),
            hint: 'Component',
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
          CustomDropdownMultiple<RequirementType>(
            width: 180,
            values: RequirementType.items,
            controller: state.typeFilterController,
            onSelected: (_) => state.notify(),
            hint: 'Type',
          ),
          const HBox(8),
          CustomDropdownMultiple<RequirementImportance>(
            width: 180,
            values: RequirementImportance.items,
            controller: state.importanceFilterController,
            onSelected: (_) => state.notify(),
            hint: 'Importance',
          ),
        ],
      ),
    );
  }
}
