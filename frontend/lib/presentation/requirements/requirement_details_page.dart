import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:testflow/debug/data.dart';
import 'package:testflow/domain/model/test_case.dart';
import 'package:testflow/domain/state/requirements/requirement_details_state.dart';
import 'package:testflow/domain/types/requirement_importance.dart';
import 'package:testflow/domain/types/requirement_status.dart';
import 'package:testflow/domain/types/requirement_type.dart';
import 'package:testflow/domain/types/test_case_execution.dart';
import 'package:testflow/presentation/common/input/custom_dropdown_multiple.dart';
import 'package:testflow/presentation/common/input/custom_dropdown_single.dart';
import 'package:testflow/presentation/common/input/custom_multiline_input.dart';
import 'package:testflow/presentation/common/input/custom_text_input.dart';
import 'package:testflow/presentation/common/layout/pane.dart';
import 'package:testflow/presentation/common/menu/context_menu.dart';
import 'package:testflow/presentation/common/navigation/navigation_path.dart';
import 'package:testflow/presentation/common/table/custom_table.dart';
import 'package:testflow/utils/palette.dart';

class RequirementDetailsPage extends StatelessWidget {
  final RequirementDetailsState state;

  const RequirementDetailsPage._(this.state);

  factory RequirementDetailsPage.instance({
    required String projectId,
    required String requirementId,
  }) => RequirementDetailsPage._(
    RequirementDetailsState(projectId: projectId, requirementId: requirementId),
  );

  @override
  Widget build(BuildContext context) {
    return StateProvider<RequirementDetailsState>(
      state: state,
      builder:
          (context, state) => Pane.scrollable(
            children: [
              PaneHeader(
                path: NavigationPath(
                  paths: ['Requirements', state.requirement.code],
                ),
                actions: [
                  ContextMenu(
                    icon: Icons.more_horiz,
                    children: [
                      ContextMenuItem(
                        icon: Icons.delete_outline,
                        text: 'Delete',
                        color: Palette.semanticError,
                        onPressed: state.onDeleteRequirement,
                      ),
                    ],
                  ),
                ],
              ),
              FormFields(state),
              Table(state),
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
      padding: const EdgeInsets.all(32),
      child: Form(
        key: state.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: CustomTextInput(
                    name: 'Name',
                    controller: state.nameController,
                    errorMessage: 'Name is required',
                  ),
                ),
                const HBox(16),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: CustomTextInput(
                          name: 'Code',
                          controller: state.idController,
                          errorMessage: 'Code is required',
                        ),
                      ),
                      const HBox(16),
                      Expanded(
                        child: CustomDropdownSingle<RequirementType>(
                          name: 'Type',
                          values: RequirementType.items,
                          controller: state.typeController,
                          errorMessage: 'Type is required',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const VBox(16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: CustomMultilineInput(
                    minLines: 5,
                    maxLines: 5,
                    name: 'Description',
                    controller: state.descriptionController,
                  ),
                ),
                const HBox(16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: CustomDropdownSingle<RequirementStatus>(
                              name: 'Status',
                              values: RequirementStatus.items,
                              controller: state.statusController,
                              errorMessage: 'Status is required',
                            ),
                          ),
                          const HBox(16),
                          Expanded(
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
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
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
                          Expanded(
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

class Table extends StatelessWidget {
  final RequirementDetailsState state;

  const Table(this.state);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: CustomTable<TestCase>(
        columns: TestCase.columns,
        rows: state.testCases,
        onSelected:
            (testCase) => state.onTestCaseSelected(
              context: context,
              testCaseId: testCase.id,
            ),
        onResetFilters: state.hasFilters ? state.onResetFilters : null,
        onCreateItem: () => state.onCreateTestCase(context),
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
          CustomDropdownMultiple<TestCaseExecution>(
            width: 200,
            values: TestCaseExecution.items,
            controller: state.executionFilterController,
            onSelected: (_) => state.notify(),
            hint: 'Component',
          ),
        ],
      ),
    );
  }
}
