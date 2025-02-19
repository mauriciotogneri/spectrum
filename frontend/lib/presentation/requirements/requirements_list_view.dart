import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:testflow/debug/data.dart';
import 'package:testflow/domain/model/requirement.dart';
import 'package:testflow/domain/state/requirements/requirements_list_state.dart';
import 'package:testflow/domain/types/requirement_importance.dart';
import 'package:testflow/domain/types/requirement_status.dart';
import 'package:testflow/domain/types/requirement_type.dart';
import 'package:testflow/presentation/common/input/custom_dropdown_multiple.dart';
import 'package:testflow/presentation/common/input/custom_dropdown_single.dart';
import 'package:testflow/presentation/common/input/custom_text_input.dart';
import 'package:testflow/presentation/common/layout/pane.dart';
import 'package:testflow/presentation/common/navigation/navigation_path.dart';
import 'package:testflow/presentation/common/table/custom_table.dart';

class RequirementsListView extends StatelessWidget {
  final RequirementsListState state;

  const RequirementsListView._(this.state);

  factory RequirementsListView.instance() =>
      RequirementsListView._(RequirementsListState());

  @override
  Widget build(BuildContext context) {
    return StateProvider<RequirementsListState>(
      state: state,
      builder:
          (context, state) => Pane.scrollable(
            children: [
              NavigationPath(paths: [Data.currentProject.name, 'Requirements']),
              Table(state),
            ],
          ),
    );
  }
}

class Table extends StatelessWidget {
  final RequirementsListState state;

  const Table(this.state);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: CustomTable<Requirement>(
        columns: Requirement.columns,
        rows: state.requirements,
        onSelected: state.onRequirementSelected,
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
