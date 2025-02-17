import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:testflow/debug/data.dart';
import 'package:testflow/domain/model/requirement.dart';
import 'package:testflow/domain/state/requirements/requirements_list_state.dart';
import 'package:testflow/domain/types/requirement_importance.dart';
import 'package:testflow/domain/types/requirement_status.dart';
import 'package:testflow/domain/types/requirement_type.dart';
import 'package:testflow/presentation/common/input/custom_dropdown_single.dart';
import 'package:testflow/presentation/common/input/custom_text_input.dart';
import 'package:testflow/presentation/common/layout/pane.dart';
import 'package:testflow/presentation/common/table/custom_table.dart';
import 'package:testflow/presentation/common/text/title_medium.dart';

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
            children: [const Header(), Table(state), const VBox(16)],
          ),
    );
  }
}

class Header extends StatelessWidget {
  const Header();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 8, left: 16, right: 16, bottom: 16),
      child: TitleMedium(text: 'Requirements'),
    );
  }
}

class Table extends StatelessWidget {
  final RequirementsListState state;

  const Table(this.state);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: CustomTable<Requirement>(
        columns: Requirement.columns,
        rows: state.requirements,
        onSelected: state.onRequirementSelected,
        onResetFilters: state.onResetFilters,
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
          CustomDropdownSingle<String>(
            width: 150,
            values:
                Data.currentProject.components
                    .map(DropdownItem.create)
                    .toList(),
            controller: state.componentFilterController,
            onSelected: (_) => state.notify(),
            allowDeselection: true,
            hint: 'Component',
          ),
          const HBox(8),
          CustomDropdownSingle<RequirementType>(
            width: 150,
            values: RequirementType.values.map(DropdownItem.create).toList(),
            controller: state.typeFilterController,
            onSelected: (_) => state.notify(),
            allowDeselection: true,
            hint: 'Type',
          ),
          const HBox(8),
          CustomDropdownSingle<RequirementStatus>(
            width: 150,
            values: RequirementStatus.values.map(DropdownItem.create).toList(),
            controller: state.statusFilterController,
            onSelected: (_) => state.notify(),
            allowDeselection: true,
            hint: 'Status',
          ),
          const HBox(8),
          CustomDropdownSingle<RequirementImportance>(
            width: 150,
            values:
                RequirementImportance.values.map(DropdownItem.create).toList(),
            controller: state.importanceFilterController,
            onSelected: (_) => state.notify(),
            allowDeselection: true,
            hint: 'Importance',
          ),
          const HBox(8),
          CustomDropdownSingle<String>(
            width: 150,
            values:
                Data.currentProject.platforms.map(DropdownItem.create).toList(),
            controller: state.platformFilterController,
            onSelected: (_) => state.notify(),
            allowDeselection: true,
            hint: 'Platform',
          ),
        ],
      ),
    );
  }
}
