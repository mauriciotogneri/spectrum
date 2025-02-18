import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:testflow/debug/data.dart';
import 'package:testflow/domain/model/requirement.dart';
import 'package:testflow/domain/model/test_case.dart';
import 'package:testflow/domain/state/requirements/requirement_details_state.dart';
import 'package:testflow/domain/types/requirement_importance.dart';
import 'package:testflow/domain/types/requirement_status.dart';
import 'package:testflow/domain/types/requirement_type.dart';
import 'package:testflow/presentation/common/input/custom_dropdown_multiple.dart';
import 'package:testflow/presentation/common/input/custom_dropdown_single.dart';
import 'package:testflow/presentation/common/input/custom_text_input.dart';
import 'package:testflow/presentation/common/layout/pane.dart';
import 'package:testflow/presentation/common/table/custom_table.dart';
import 'package:testflow/presentation/common/text/title_large.dart';
import 'package:testflow/presentation/common/text/title_medium.dart';
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
          (context, state) => Pane.scrollable(
            children: [
              const TitleMedium(text: 'Requirement details'),
              FormFields(state),
              //TestCasesBlock(state),
            ],
          ),
    );
  }
}

class FormFields extends StatelessWidget {
  final RequirementDetailsState state;

  const FormFields(this.state);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: state.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Flexible(
                  flex: 2,
                  child: CustomTextInput(
                    name: 'Name',
                    controller: state.nameController,
                    errorMessage: 'Name is required',
                  ),
                ),
                const HBox(16),
                Flexible(
                  flex: 1,
                  child: CustomTextInput(
                    name: 'ID',
                    controller: state.idController,
                    //errorMessage: 'ID is required',
                  ),
                ),
                const HBox(16),
                Flexible(
                  flex: 1,
                  child: CustomDropdownSingle<RequirementType>(
                    name: 'Type',
                    values: RequirementType.items,
                    controller: state.typeController,
                    errorMessage: 'Type is required',
                  ),
                ),
              ],
            ),
            const VBox(16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  flex: 1,
                  child: CustomTextInput(
                    minLines: 5,
                    maxLines: 5,
                    name: 'Description',
                    controller: state.descriptionController,
                  ),
                ),
                const HBox(16),
                Flexible(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Flexible(
                            flex: 1,
                            child: CustomDropdownSingle<RequirementStatus>(
                              name: 'Status',
                              values: RequirementStatus.items,
                              controller: state.statusController,
                              errorMessage: 'Status is required',
                            ),
                          ),
                          const HBox(16),
                          Flexible(
                            flex: 1,
                            child: CustomDropdownSingle<RequirementImportance>(
                              name: 'Importance',
                              values:
                                  RequirementImportance.values
                                      .map(DropdownItem.create)
                                      .toList(),
                              controller: state.importanceController,
                              errorMessage: 'Importance is required',
                            ),
                          ),
                        ],
                      ),
                      const VBox(16),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Flexible(
                            flex: 1,
                            child: CustomDropdownSingle<String>(
                              name: 'Component',
                              values: DropdownItem.fromList(
                                Data.currentProject.components,
                              ),
                              controller: state.componentController,
                              errorMessage: 'Component is required',
                            ),
                          ),
                          const HBox(16),
                          Flexible(
                            flex: 1,
                            child: CustomDropdownMultiple<String>(
                              name: 'Platforms',
                              values: DropdownItem.fromList(
                                Data.currentProject.platforms,
                              ),
                              controller: state.platformsController,
                              errorMessage: 'Platforms is required',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const VBox(16),
          ],
        ),
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
          const HorizontalDivider(
            color: Palette.borderInputEnabled,
            height: 0.5,
          ),
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
          /*TableColumn(name: 'Name'),
          TableColumn(name: 'Is automated', width: 100),
          TableColumn(
            name: 'Last run',
            width: 100,
            alignment: Alignment.centerRight,
          ),*/
        ],
        rows: state.testCases,
        onSelected: state.onTestCaseSelected,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CustomTextInput(
                name: 'Name',
                controller: CustomTextInputController()..text = testCase.name,
                errorMessage: 'Name is required',
              ),
              const HBox(16),
              Padding(
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
            ],
          ),
          CustomTextInput(
            maxLines: 4,
            name: 'Preconditions',
            controller:
                CustomTextInputController()..text = testCase.preconditions,
          ),
          CustomTextInput(
            maxLines: 4,
            name: 'Steps',
            controller: CustomTextInputController()..text = testCase.steps,
          ),
          CustomTextInput(
            maxLines: 4,
            name: 'Expected result',
            controller: CustomTextInputController()..text = testCase.expected,
          ),
        ],
      ),
    );
  }
}
