import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:testflow/debug/data.dart';
import 'package:testflow/domain/model/requirement.dart';
import 'package:testflow/domain/state/requirements/requirements_list_state.dart';
import 'package:testflow/domain/types/requirement_importance.dart';
import 'package:testflow/domain/types/requirement_status.dart';
import 'package:testflow/domain/types/requirement_type.dart';
import 'package:testflow/presentation/common/button/primary_button.dart';
import 'package:testflow/presentation/common/dropdown/dropdown_input_multiple.dart';
import 'package:testflow/presentation/common/input/text_input_field.dart';
import 'package:testflow/presentation/common/table/custom_table.dart';
import 'package:testflow/presentation/common/text/title_4.dart';
import 'package:testflow/presentation/common/view/base_view.dart';

class RequirementsListView extends StatelessWidget {
  final RequirementsListState state;

  const RequirementsListView._(this.state);

  factory RequirementsListView.instance() =>
      RequirementsListView._(RequirementsListState());

  @override
  Widget build(BuildContext context) {
    return StateProvider<RequirementsListState>(
      state: state,
      builder: (context, state) => BaseView.normal(
        header: const Header(),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const VBox(16),
            TableFilters(state),
            const VBox(16),
            Table(state),
          ],
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header();

  @override
  Widget build(BuildContext context) {
    return const Title4(text: 'Requirements');
  }
}

class TableFilters extends StatelessWidget {
  final RequirementsListState state;

  const TableFilters(this.state);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextInputField(
          width: 300,
          hint: 'Filter…',
          canClear: true,
          controller: state.queryFilterController,
          onChange: (_) => state.notify(),
        ),
        DropdownInputMultiple<RequirementType>(
          width: 200,
          values: RequirementType.values,
          controller: state.typeFilterController,
          onChange: (_) => state.notify(),
          allowDeselection: true,
          hint: 'Type',
        ),
        DropdownInputMultiple<RequirementStatus>(
          width: 200,
          values: RequirementStatus.values,
          controller: state.statusFilterController,
          onChange: (_) => state.notify(),
          allowDeselection: true,
          hint: 'Status',
        ),
        DropdownInputMultiple<String>(
          width: 200,
          values: Data.currentProject.components,
          controller: state.componentFilterController,
          onChange: (_) => state.notify(),
          allowDeselection: true,
          hint: 'Component',
        ),
        DropdownInputMultiple<String>(
          width: 200,
          values: Data.currentProject.platforms,
          controller: state.platformFilterController,
          onChange: (_) => state.notify(),
          allowDeselection: true,
          hint: 'Platform',
        ),
        DropdownInputMultiple<RequirementImportance>(
          width: 200,
          values: RequirementImportance.values,
          controller: state.importanceFilterController,
          onChange: (_) => state.notify(),
          allowDeselection: true,
          hint: 'Importance',
        ),
        const Spacer(),
        PrimaryButton(
          icon: Icons.add,
          text: 'Add',
          onPressed: () => state.onCreateRequirement(context),
        ),
      ],
    );
  }
}

class Table extends StatelessWidget {
  final RequirementsListState state;

  const Table(this.state);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: CustomTable<Requirement>(
        columns: const [
          CustomTableColumn(name: 'ID', ratio: 0.10),
          CustomTableColumn(name: 'Name', ratio: 0.25),
          CustomTableColumn(name: 'Component', ratio: 0.15),
          CustomTableColumn(name: 'Type', ratio: 0.15),
          CustomTableColumn(name: 'Status', ratio: 0.10),
          CustomTableColumn(name: 'Importance', ratio: 0.15),
          CustomTableColumn(name: 'Test cases', ratio: 0.10),
        ],
        rows: state.requirements,
        onRowSelected: state.onRequirementSelected,
      ),
    );
  }
}
