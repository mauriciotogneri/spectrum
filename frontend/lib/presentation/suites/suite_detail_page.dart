import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:testflow/debug/data.dart';
import 'package:testflow/domain/model/test_case.dart';
import 'package:testflow/domain/state/suites/suite_detail_state.dart';
import 'package:testflow/domain/types/requirement_importance.dart';
import 'package:testflow/domain/types/requirement_status.dart';
import 'package:testflow/domain/types/requirement_type.dart';
import 'package:testflow/domain/types/test_case_execution.dart';
import 'package:testflow/presentation/common/card/metadata_card.dart';
import 'package:testflow/presentation/common/input/custom_dropdown_multiple.dart';
import 'package:testflow/presentation/common/input/custom_dropdown_single.dart';
import 'package:testflow/presentation/common/input/custom_multiline_input.dart';
import 'package:testflow/presentation/common/input/custom_text_input.dart';
import 'package:testflow/presentation/common/layout/pane.dart';
import 'package:testflow/presentation/common/menu/context_menu.dart';
import 'package:testflow/presentation/common/navigation/navigation_path.dart';
import 'package:testflow/presentation/common/table/custom_table.dart';
import 'package:testflow/utils/formatter.dart';
import 'package:testflow/utils/navigation.dart';
import 'package:testflow/utils/palette.dart';

class SuiteDetailPage extends StatelessWidget {
  final SuiteDetailState state;

  const SuiteDetailPage._(this.state);

  factory SuiteDetailPage.instance({
    required String projectId,
    required String suiteId,
  }) => SuiteDetailPage._(
    SuiteDetailState(projectId: projectId, suiteId: suiteId),
  );

  @override
  Widget build(BuildContext context) {
    return StateProvider<SuiteDetailState>(
      state: state,
      builder:
          (context, state) => state.isLoading ? const Empty() : Content(state),
    );
  }
}

class Content extends StatelessWidget {
  final SuiteDetailState state;

  const Content(this.state);

  @override
  Widget build(BuildContext context) {
    return Pane.scrollable(children: [Header(state), Body(state)]);
  }
}

class Header extends StatelessWidget {
  final SuiteDetailState state;

  const Header(this.state);

  @override
  Widget build(BuildContext context) {
    return PaneHeader(
      path: NavigationPath(
        paths: [
          PathItem(
            text: 'Requirements',
            path: Navigation.requirementListPath(state.projectId),
          ),
          PathItem(text: state.requirement.code),
        ],
      ),
      actions: [
        ContextMenu(
          offset: const Offset(-45, 0),
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
    );
  }
}

class Body extends StatelessWidget {
  final SuiteDetailState state;

  const Body(this.state);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [FormFields(state), Table(state)],
          ),
        ),
        const Metadata(),
        const HBox(32),
      ],
    );
  }
}

class FormFields extends StatelessWidget {
  final SuiteDetailState state;

  const FormFields(this.state);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 32, right: 32, bottom: 32, left: 32),
      child: Form(
        key: state.formKey.key,
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
  final SuiteDetailState state;

  const Table(this.state);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 32, bottom: 32, left: 32),
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

class Metadata extends StatelessWidget {
  const Metadata();

  @override
  Widget build(BuildContext context) {
    return MetadataCard([
      MetadataItem(
        label: 'Created on',
        value: Formatter.fullDateTime(DateTime.now()),
      ),
      const MetadataItem(label: 'Created by', value: 'John Doe'),
      MetadataItem(
        label: 'Updated on',
        value: Formatter.fullDateTime(DateTime.now()),
      ),
      const MetadataItem(label: 'Updated by', value: 'Jane Doe'),
    ]);
  }
}
