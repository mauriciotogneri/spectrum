import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:testflow/debug/data.dart';
import 'package:testflow/domain/model/suite.dart';
import 'package:testflow/domain/state/suites/suite_list_state.dart';
import 'package:testflow/domain/types/requirement_importance.dart';
import 'package:testflow/domain/types/requirement_status.dart';
import 'package:testflow/domain/types/requirement_type.dart';
import 'package:testflow/presentation/common/input/custom_dropdown_multiple.dart';
import 'package:testflow/presentation/common/input/custom_dropdown_single.dart';
import 'package:testflow/presentation/common/input/custom_text_input.dart';
import 'package:testflow/presentation/common/layout/pane.dart';
import 'package:testflow/presentation/common/navigation/navigation_path.dart';
import 'package:testflow/presentation/common/table/custom_table.dart';

class SuiteListPage extends StatelessWidget {
  final SuiteListState state;

  const SuiteListPage._(this.state);

  factory SuiteListPage.instance() => SuiteListPage._(SuiteListState());

  @override
  Widget build(BuildContext context) {
    return StateProvider<SuiteListState>(
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
  final SuiteListState state;

  const Table(this.state);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: CustomTable<Suite>(
        columns: Suite.columns,
        rows: state.suites,
        onSelected: state.onSuiteSelected,
        onResetFilters: state.hasFilters ? state.onResetFilters : null,
        onCreateItem: () => state.onCreateRequirement(context),
        filters: [
          CustomTextInput(
            width: 300,
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
          CustomDropdownMultiple<RequirementStatus>(
            width: 180,
            values: RequirementStatus.items,
            controller: state.statusFilterController,
            onSelected: (_) => state.notify(),
            hint: 'Status',
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
