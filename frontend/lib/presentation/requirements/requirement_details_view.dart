import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:testflow/domain/model/requirement.dart';
import 'package:testflow/domain/model/test_case.dart';
import 'package:testflow/domain/state/requirements/requirement_details_state.dart';
import 'package:testflow/presentation/common/input/custom_text_input.dart';
import 'package:testflow/presentation/common/layout/pane.dart';
import 'package:testflow/presentation/common/table/custom_table.dart';
import 'package:testflow/presentation/common/text/title_large.dart';
import 'package:testflow/presentation/common/text/title_medium.dart';
import 'package:testflow/presentation/common/text/title_small.dart';
import 'package:testflow/utils/palette.dart';

class RequirementDetailsView extends StatelessWidget {
  final RequirementDetailsState state;

  const RequirementDetailsView._(this.state);

  factory RequirementDetailsView.instance({required Requirement requirement}) =>
      RequirementDetailsView._(
        RequirementDetailsState(requirement: requirement),
      );

  @override
  Widget build(BuildContext context) {
    return StateProvider<RequirementDetailsState>(
      state: state,
      builder:
          (context, state) => Pane.withBack(
            header: const TitleMedium(text: 'Requirement details'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [FormFields(state), TestCasesBlock(state)],
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
    return Form(
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
                input: CustomTextInput(
                  controller: state.nameController,
                  //errorMessage: 'Name is required',
                ),
              ),
              InputEntry(
                flex: 1,
                label: 'ID',
                input: CustomTextInput(
                  controller: state.idController,
                  //errorMessage: 'ID is required',
                ),
              ),
              /*InputEntry(
                flex: 1,
                label: 'Type',
                input: CustomDropdownSingle<RequirementType>(
                  values:
                      RequirementType.values.map(DropdownItem.create).toList(),
                  controller: state.typeController,
                  errorMessage: 'Type is required',
                ),
              ),*/
            ],
          ),
          Row(
            children: [
              InputEntry(
                flex: 2,
                label: 'Description',
                input: CustomTextInput(
                  maxLines: 5,
                  controller: state.descriptionController,
                ),
              ),
              const Flexible(
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
                          /*InputEntry(
                            flex: 1,
                            label: 'Status',
                            input: CustomDropdownSingle<RequirementStatus>(
                              values:
                                  RequirementStatus.values
                                      .map(DropdownItem.create)
                                      .toList(),
                              controller: state.statusController,
                              errorMessage: 'Status is required',
                            ),
                          ),
                          InputEntry(
                            flex: 1,
                            label: 'Importance',
                            input: CustomDropdownSingle<RequirementImportance>(
                              values:
                                  RequirementImportance.values
                                      .map(DropdownItem.create)
                                      .toList(),
                              controller: state.importanceController,
                              errorMessage: 'Importance is required',
                            ),
                          ),*/
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Row(
                        children: [
                          /*InputEntry(
                            flex: 1,
                            label: 'Component',
                            input: CustomDropdownSingle<String>(
                              values:
                                  Data.currentProject.components
                                      .map(DropdownItem.create)
                                      .toList(),
                              controller: state.componentController,
                              errorMessage: 'Component is required',
                            ),
                          ),
                          InputEntry(
                            flex: 1,
                            label: 'Platforms',
                            input: CustomDropdownSingle<String>(
                              values:
                                  Data.currentProject.platforms
                                      .map(DropdownItem.create)
                                      .toList(),
                              controller: state.platformsController,
                              allowDeselection: true,
                              errorMessage: 'Platforms is required',
                            ),
                          ),*/
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
        children: [TitleSmall(text: label), input],
      ),
    );
  }
}

class TestCasesBlock extends StatelessWidget {
  final RequirementDetailsState state;

  const TestCasesBlock(this.state);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const HorizontalDivider(color: Palette.borderTable, height: 0.5),
          const VBox(16),
          const TitleLarge(text: 'Test cases'),
          const VBox(16),
          Expanded(
            child: Row(
              children: [
                Flexible(child: Table(state)),
                Flexible(
                  child:
                      (state.selectedTestCase != null)
                          ? TestCaseDetails(state.selectedTestCase!)
                          : const Empty(),
                ),
              ],
            ),
          ),
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
          CustomTableColumn(name: 'Name', ratio: 0.5),
          CustomTableColumn(name: 'Is automated', ratio: 0.25),
          CustomTableColumn(
            name: 'Last run',
            ratio: 0.25,
            alignment: Alignment.centerRight,
          ),
        ],
        rows: state.testCases,
        onRowSelected: state.onTestCaseSelected,
      ),
    );
  }
}

class TestCaseDetails extends StatelessWidget {
  final TestCase testCase;

  const TestCaseDetails(this.testCase);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              InputEntry(
                flex: 4,
                label: 'Name',
                input: CustomTextInput(
                  controller: TextInputController()..text = testCase.name,
                  //errorMessage: 'Name is required',
                ),
              ),
              const HBox(16),
              InputEntry(
                flex: 1,
                label: 'Automated',
                input: Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Switch(
                    value: testCase.isAutomated,
                    padding: const EdgeInsets.only(
                      top: 0,
                      bottom: 0,
                      left: 8,
                      right: 0,
                    ),
                    onChanged: (_) {},
                  ),
                ),
              ),
            ],
          ),
          InputEntry(
            flex: 1,
            label: 'Preconditions',
            input: CustomTextInput(
              maxLines: 4,
              controller: TextInputController()..text = testCase.preconditions,
            ),
          ),
          InputEntry(
            flex: 1,
            label: 'Steps',
            input: CustomTextInput(
              maxLines: 4,
              controller: TextInputController()..text = testCase.steps,
            ),
          ),
          InputEntry(
            flex: 1,
            label: 'Expected result',
            input: CustomTextInput(
              maxLines: 4,
              controller: TextInputController()..text = testCase.expected,
            ),
          ),
        ],
      ),
    );
  }
}
