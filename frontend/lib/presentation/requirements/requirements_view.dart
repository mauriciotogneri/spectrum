import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:testflow/debug/data.dart';
import 'package:testflow/domain/state/requirements/requirements_state.dart';
import 'package:testflow/domain/types/importance.dart';
import 'package:testflow/domain/types/requirement_type.dart';
import 'package:testflow/presentation/common/dropdown/dropdown_input.dart';
import 'package:testflow/presentation/common/input/text_input_field.dart';
import 'package:testflow/presentation/common/table/custom_table.dart';
import 'package:testflow/presentation/common/text/title_4.dart';

class RequirementsView extends StatelessWidget {
  final RequirementsState state;

  const RequirementsView._(this.state);

  factory RequirementsView.instance() =>
      RequirementsView._(RequirementsState());

  @override
  Widget build(BuildContext context) {
    return StateProvider<RequirementsState>(
      state: state,
      builder: (state, context) => Padding(
        padding: const EdgeInsets.only(
          top: 16,
          left: 16,
          right: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Header(),
            const VBox(16),
            TableFilters(this.state),
            const VBox(16),
            Table(this.state),
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
  final RequirementsState state;

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
          onChanged: state.onQueryFilterChanged,
        ),
        DropdownInput<RequirementType>(
          width: 250,
          values: RequirementType.values,
          controller: state.typeFilterController,
          onChangeMultiple: state.onTypeFilterChanged,
          allowDeselection: true,
          hint: 'Type',
        ),
        DropdownInput<String>(
          width: 300,
          values: Data.currentProject.components,
          controller: state.componentFilterController,
          onChangeMultiple: state.onComponentFilterChanged,
          allowDeselection: true,
          hint: 'Component',
        ),
        DropdownInput<String>(
          width: 300,
          values: Data.currentProject.platforms,
          controller: state.platformFilterController,
          onChangeMultiple: state.onPlatformFilterChanged,
          allowDeselection: true,
          hint: 'Platform',
        ),
        DropdownInput<Importance>(
          width: 250,
          values: Importance.values,
          controller: state.importanceFilterController,
          onChangeMultiple: state.onImportanceFilterChanged,
          allowDeselection: true,
          hint: 'Importance',
        ),
      ],
    );
  }
}

class Table extends StatelessWidget {
  final RequirementsState state;

  const Table(this.state);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomTable(
        columns: const [
          CustomTableColumn(name: 'Name', ratio: 0.25),
          CustomTableColumn(name: 'Type', ratio: 0.15),
          CustomTableColumn(name: 'Component', ratio: 0.15),
          CustomTableColumn(name: 'Platforms', ratio: 0.20),
          CustomTableColumn(name: 'Importance', ratio: 0.15),
          CustomTableColumn(name: 'Test cases', ratio: 0.10),
        ],
        rows: state.requirements,
        onRowSelected: state.onRequirementSelected,
      ),
    );
  }
}
