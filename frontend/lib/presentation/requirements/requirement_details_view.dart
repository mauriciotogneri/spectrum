import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:testflow/debug/data.dart';
import 'package:testflow/domain/model/requirement.dart';
import 'package:testflow/domain/model/test_case.dart';
import 'package:testflow/domain/state/requirements/requirement_details_state.dart';
import 'package:testflow/domain/types/requirement_importance.dart';
import 'package:testflow/domain/types/requirement_status.dart';
import 'package:testflow/domain/types/requirement_type.dart';
import 'package:testflow/presentation/common/dropdown/dropdown_input_multiple.dart';
import 'package:testflow/presentation/common/dropdown/dropdown_input_single.dart';
import 'package:testflow/presentation/common/input/text_input_field.dart';
import 'package:testflow/presentation/common/table/custom_table.dart';
import 'package:testflow/presentation/common/text/input_label.dart';
import 'package:testflow/presentation/common/text/title_4.dart';
import 'package:testflow/presentation/common/view/base_view.dart';

class RequirementDetailsView extends StatelessWidget {
  final RequirementDetailsState state;

  const RequirementDetailsView._(this.state);

  factory RequirementDetailsView.instance({
    required Requirement requirement,
  }) =>
      RequirementDetailsView._(
          RequirementDetailsState(requirement: requirement));

  @override
  Widget build(BuildContext context) {
    return StateProvider<RequirementDetailsState>(
      state: state,
      builder: (context, state) => BaseView.withBack(
        header: const Title4(text: 'Requirement details'),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FormFields(state),
            Table(state),
          ],
        ),
      ),
    );
  }
}

class FormFields extends StatelessWidget {
  final RequirementDetailsState state;

  const FormFields(this.state);

  @override
  Widget build(BuildContext context) {
    return ShadForm(
      key: state.formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              InputEntry(
                flex: 2,
                label: 'Name',
                input: TextInputField(
                  isForm: true,
                  controller: state.nameController,
                  errorMessage: 'Name is required',
                ),
              ),
              InputEntry(
                flex: 1,
                label: 'ID',
                input: TextInputField(
                  isForm: true,
                  controller: state.idController,
                  errorMessage: 'ID is required',
                ),
              ),
              InputEntry(
                flex: 1,
                label: 'Type',
                input: DropdownInputSingle<RequirementType>(
                  values: RequirementType.values,
                  controller: state.typeController,
                  isForm: true,
                  errorMessage: 'Type is required',
                ),
              ),
            ],
          ),
          Row(
            children: [
              InputEntry(
                flex: 2,
                label: 'Description',
                input: TextInputField(
                  isForm: true,
                  maxLines: 5,
                  controller: state.descriptionController,
                ),
              ),
              Flexible(
                flex: 2,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      flex: 1,
                      child: Row(
                        children: [
                          InputEntry(
                            flex: 1,
                            label: 'Status',
                            input: DropdownInputSingle<RequirementStatus>(
                              values: RequirementStatus.values,
                              controller: state.statusController,
                              isForm: true,
                              errorMessage: 'Status is required',
                            ),
                          ),
                          InputEntry(
                            flex: 1,
                            label: 'Importance',
                            input: DropdownInputSingle<RequirementImportance>(
                              values: RequirementImportance.values,
                              controller: state.importanceController,
                              isForm: true,
                              errorMessage: 'Importance is required',
                            ),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Row(
                        children: [
                          InputEntry(
                            flex: 1,
                            label: 'Component',
                            input: DropdownInputSingle<String>(
                              values: Data.currentProject.components,
                              controller: state.componentController,
                              isForm: true,
                              errorMessage: 'Component is required',
                            ),
                          ),
                          InputEntry(
                            flex: 1,
                            label: 'Platforms',
                            input: DropdownInputMultiple<String>(
                              values: Data.currentProject.platforms,
                              controller: state.platformsController,
                              allowDeselection: true,
                              isForm: true,
                              errorMessage: 'Platforms is required',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const VBox(16),
        ],
      ),
    );
  }
}

class InputEntry extends StatelessWidget {
  final int flex;
  final String label;
  final Widget input;

  const InputEntry({
    required this.flex,
    required this.label,
    required this.input,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: flex,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          InputLabel(label),
          input,
        ],
      ),
    );
  }
}

class Table extends StatelessWidget {
  final RequirementDetailsState state;

  const Table(this.state);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: CustomTable<TestCase>(
        width: 995,
        columns: const [
          CustomTableColumn(name: 'Name', ratio: 0.6),
          CustomTableColumn(name: 'Is automated', ratio: 0.2),
          CustomTableColumn(
            name: 'Last run',
            ratio: 0.2,
            alignment: Alignment.centerRight,
          ),
        ],
        rows: state.testCases,
        onRowSelected: state.onTestCaseSelected,
      ),
    );
  }
}
