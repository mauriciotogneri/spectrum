import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:testflow/domain/model/test_run.dart';
import 'package:testflow/domain/state/test_cases/test_case_detail_state.dart';
import 'package:testflow/domain/types/test_case_execution.dart';
import 'package:testflow/domain/types/test_run_reproducibility.dart';
import 'package:testflow/domain/types/test_run_result.dart';
import 'package:testflow/presentation/attachments/attachments_table.dart';
import 'package:testflow/presentation/common/card/metadata_card.dart';
import 'package:testflow/presentation/common/input/custom_dropdown_multiple.dart';
import 'package:testflow/presentation/common/input/custom_dropdown_single.dart';
import 'package:testflow/presentation/common/input/custom_multiline_input.dart';
import 'package:testflow/presentation/common/input/custom_text_input.dart';
import 'package:testflow/presentation/common/layout/pane.dart';
import 'package:testflow/presentation/common/menu/context_menu.dart';
import 'package:testflow/presentation/common/navigation/navigation_path.dart';
import 'package:testflow/presentation/common/table/custom_table.dart';
import 'package:testflow/presentation/tabs/custom_tabs.dart';
import 'package:testflow/utils/formatter.dart';
import 'package:testflow/utils/navigation.dart';
import 'package:testflow/utils/palette.dart';

class TestCaseDetailPage extends StatelessWidget {
  final TestCaseDetailState state;

  const TestCaseDetailPage._(this.state);

  factory TestCaseDetailPage.instance({
    required String projectId,
    required String requirementId,
    required String testCaseId,
  }) => TestCaseDetailPage._(
    TestCaseDetailState(
      projectId: projectId,
      requirementId: requirementId,
      testCaseId: testCaseId,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return StateProvider<TestCaseDetailState>(
      state: state,
      builder:
          (context, state) => state.isLoading ? const Empty() : Content(state),
    );
  }
}

class Content extends StatelessWidget {
  final TestCaseDetailState state;

  const Content(this.state);

  @override
  Widget build(BuildContext context) {
    return Pane.scrollable(children: [Header(state), Body(state)]);
  }
}

class Header extends StatelessWidget {
  final TestCaseDetailState state;

  const Header(this.state);

  @override
  Widget build(BuildContext context) {
    return PaneHeader(
      path: NavigationPath(
        paths: [
          PathItem(
            text: 'Requirements',
            path: Navigation.requirementListPath(projectId: state.projectId),
          ),
          PathItem(
            text: state.requirement.code,
            path: Navigation.requirementDetailPath(
              projectId: state.projectId,
              requirementId: state.requirement.id,
            ),
          ),
          PathItem(text: state.testCase.name),
        ],
      ),
      actions: [
        ContextMenu(
          offset: const Offset(-70, 0),
          icon: Icons.more_horiz,
          children: [
            ContextMenuItem(
              icon: Icons.bolt_rounded,
              text: 'Quick test',
              color: Palette.textTitle,
              onPressed: state.onQuickTest,
            ),
            ContextMenuItem(
              icon: Icons.delete_outline,
              text: 'Delete',
              color: Palette.semanticError,
              onPressed: () => state.onDeleteTestCase(context),
            ),
          ],
        ),
      ],
    );
  }
}

class Body extends StatelessWidget {
  final TestCaseDetailState state;

  const Body(this.state);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: FormFields(state)),
            Metadata(state),
            const HBox(32),
          ],
        ),
        TabSection(state),
      ],
    );
  }
}

class FormFields extends StatelessWidget {
  final TestCaseDetailState state;

  const FormFields(this.state);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 32, right: 32, bottom: 16, left: 32),
      child: Form(
        key: state.formKey.key,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: CustomTextInput(
                    name: 'Name',
                    controller: state.nameController,
                    errorMessage: 'Name is required',
                  ),
                ),
                const HBox(16),
                CustomDropdownSingle<TestCaseExecution>(
                  width: 150,
                  name: 'Execution',
                  values: TestCaseExecution.items,
                  controller: state.executionController,
                  errorMessage: 'Execution is required',
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
                    minLines: 6,
                    maxLines: 6,
                    name: 'Preconditions',
                    controller: state.preconditionsController,
                  ),
                ),
                const HBox(16),
                Expanded(
                  child: CustomTextInput(
                    minLines: 6,
                    maxLines: 6,
                    name: 'Steps',
                    controller: state.stepsController,
                  ),
                ),
                const HBox(16),
                Expanded(
                  child: CustomTextInput(
                    minLines: 6,
                    maxLines: 6,
                    name: 'Expected result',
                    controller: state.expectedController,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Metadata extends StatelessWidget {
  final TestCaseDetailState state;

  const Metadata(this.state);

  @override
  Widget build(BuildContext context) {
    return MetadataCard([
      MetadataItem(
        label: 'Created on',
        value: Formatter.dateMonthYear(state.testCase.createdOn),
        tooltip: Formatter.fullDateTime(state.testCase.createdOn),
      ),
      MetadataItem(label: 'Created by', value: state.testCase.createdBy),
      MetadataItem(
        label: 'Updated on',
        value: Formatter.dateMonthYear(state.testCase.updatedOn),
        tooltip: Formatter.fullDateTime(state.testCase.updatedOn),
      ),
      MetadataItem(label: 'Updated by', value: state.testCase.updatedBy),
      MetadataItem(
        label: 'Last run',
        value:
            '${Formatter.dateMonthYear(state.testCase.lastRun)}\n${Formatter.daysAgo(state.testCase.lastRun)}',
        tooltip: Formatter.fullDateTime(state.testCase.lastRun),
      ),
    ]);
  }
}

class TabSection extends StatelessWidget {
  final TestCaseDetailState state;

  const TabSection(this.state);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 32, bottom: 32, left: 32),
      child: CustomTabs(
        tabs: const [
          TabItem(title: 'History', width: 150, icon: Icons.history_outlined),
          TabItem(
            title: 'Attachments',
            width: 150,
            icon: Icons.attachment_outlined,
          ),
        ],
        children: [Table(state), AttachmentsTable.instance()],
      ),
    );
  }
}

class Table extends StatelessWidget {
  final TestCaseDetailState state;

  const Table(this.state);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: CustomTable<TestRun>(
        columns: TestRun.columns,
        rows: state.testRuns,
        onSelected:
            (testRun) =>
                state.onTestRunSelected(context: context, testRun: testRun),
        onResetFilters: state.hasFilters ? state.onResetFilters : null,
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
          CustomDropdownMultiple<TestRunResult>(
            width: 200,
            values: TestRunResult.items,
            controller: state.resultFilterController,
            onSelected: (_) => state.notify(),
            hint: 'Result',
          ),
          const HBox(8),
          CustomDropdownMultiple<TestRunReproducibility>(
            width: 200,
            values: TestRunReproducibility.items,
            controller: state.reproducibilityFilterController,
            onSelected: (_) => state.notify(),
            hint: 'Reproducibility',
          ),
        ],
      ),
    );
  }
}
