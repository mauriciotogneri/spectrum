import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:testflow/debug/data.dart';
import 'package:testflow/domain/model/test_session.dart';
import 'package:testflow/domain/state/test_suites/test_suite_detail_state.dart';
import 'package:testflow/domain/types/requirement_importance.dart';
import 'package:testflow/domain/types/requirement_type.dart';
import 'package:testflow/domain/types/test_session_status.dart';
import 'package:testflow/presentation/attachments/attachments_table.dart';
import 'package:testflow/presentation/common/card/metadata_card.dart';
import 'package:testflow/presentation/common/input/custom_dropdown_multiple.dart';
import 'package:testflow/presentation/common/input/custom_dropdown_single.dart';
import 'package:testflow/presentation/common/input/custom_text_input.dart';
import 'package:testflow/presentation/common/layout/pane.dart';
import 'package:testflow/presentation/common/menu/context_menu.dart';
import 'package:testflow/presentation/common/navigation/navigation_path.dart';
import 'package:testflow/presentation/common/table/custom_table.dart';
import 'package:testflow/presentation/tabs/custom_tabs.dart';
import 'package:testflow/utils/formatter.dart';
import 'package:testflow/utils/navigation.dart';
import 'package:testflow/utils/palette.dart';

class TestSuiteDetailPage extends StatelessWidget {
  final TestSuiteDetailState state;

  const TestSuiteDetailPage._(this.state);

  factory TestSuiteDetailPage.instance({
    required String projectId,
    required String testSuiteId,
  }) => TestSuiteDetailPage._(
    TestSuiteDetailState(projectId: projectId, testSuiteId: testSuiteId),
  );

  @override
  Widget build(BuildContext context) {
    return StateProvider<TestSuiteDetailState>(
      state: state,
      builder:
          (context, state) => state.isLoading ? const Empty() : Content(state),
    );
  }
}

class Content extends StatelessWidget {
  final TestSuiteDetailState state;

  const Content(this.state);

  @override
  Widget build(BuildContext context) {
    return Pane.scrollable(children: [Header(state), Body(state)]);
  }
}

class Header extends StatelessWidget {
  final TestSuiteDetailState state;

  const Header(this.state);

  @override
  Widget build(BuildContext context) {
    return PaneHeader(
      path: NavigationPath(
        paths: [
          PathItem(
            text: 'Suites',
            path: Navigation.testSuiteListPath(projectId: state.projectId),
          ),
          PathItem(text: state.testSuite.name),
        ],
      ),
      actions: [
        ContextMenu(
          type: ContextButton.iconButton,
          offset: const Offset(-95, 0),
          icon: Icons.more_horiz,
          children: [
            ContextMenuItem(
              icon: Icons.play_arrow,
              text: 'Start session',
              color: Palette.textTitle,
              onPressed: () => state.onStartSession(context),
            ),
            ContextMenuItem(
              icon: Icons.delete_outline,
              text: 'Delete',
              color: Palette.semanticError,
              onPressed: () => state.onDeleteTestSuite(context),
            ),
          ],
        ),
      ],
    );
  }
}

class Body extends StatelessWidget {
  final TestSuiteDetailState state;

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
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [FormFields(state)],
              ),
            ),
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
  final TestSuiteDetailState state;

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
            CustomTextInput(
              name: 'Name',
              controller: state.nameController,
              errorMessage: 'Name is required',
            ),
            const VBox(16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: CustomDropdownMultiple<RequirementType>(
                    name: 'Type',
                    values: RequirementType.items,
                    controller: state.typeController,
                    errorMessage: 'Type is required',
                  ),
                ),
                const HBox(16),
                Expanded(
                  child: CustomDropdownMultiple<RequirementImportance>(
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
                  child: CustomDropdownMultiple<String>(
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
            const VBox(16),
          ],
        ),
      ),
    );
  }
}

class Metadata extends StatelessWidget {
  final TestSuiteDetailState state;

  const Metadata(this.state);

  @override
  Widget build(BuildContext context) {
    return MetadataCard([
      MetadataItem(
        label: 'Created on',
        value: Formatter.dateMonthYear(state.testSuite.createdOn),
        tooltip: Formatter.fullDateTime(state.testSuite.createdOn),
      ),
      MetadataItem(label: 'Created by', value: state.testSuite.createdBy),
      MetadataItem(
        label: 'Updated on',
        value: Formatter.dateMonthYear(state.testSuite.updatedOn),
        tooltip: Formatter.fullDateTime(state.testSuite.updatedOn),
      ),
      MetadataItem(label: 'Updated by', value: state.testSuite.updatedBy),
      const MetadataItem(label: 'Capturing', value: '30 requirements'),
    ]);
  }
}

class Table extends StatelessWidget {
  final TestSuiteDetailState state;

  const Table(this.state);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: CustomTable<TestSession, TestSessionColumn, void>(
        columns: TestSession.columns,
        rows: state.testSessions,
        onSelected:
            (testSession) => state.onTestSessionSelected(
              context: context,
              testSessionId: testSession.id,
            ),
        onResetFilters: state.hasFilters ? state.onResetFilters : null,
        filters: [
          CustomTextInput(
            width: 250,
            hint: 'Filter…',
            canClear: true,
            prefixIcon: Icons.search,
            controller: state.queryFilterController,
            onChanged: (_) => state.notify(),
          ),
          const HBox(8),
          CustomDropdownMultiple<TestSessionStatus>(
            width: 200,
            values: TestSessionStatus.items,
            controller: state.statusFilterController,
            onSelected: (_) => state.notify(),
            hint: 'Status',
          ),
          const HBox(8),
          CustomDropdownMultiple<String>(
            width: 180,
            values: DropdownItem.fromList(Data.currentProject.environments),
            controller: state.environmentFilterController,
            onSelected: (_) => state.notify(),
            hint: 'Environment',
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
          CustomDropdownMultiple<String>(
            width: 180,
            values: DropdownItem.fromList(Data.currentProject.devices),
            controller: state.deviceFilterController,
            onSelected: (_) => state.notify(),
            hint: 'Device',
          ),
        ],
      ),
    );
  }
}

class TabSection extends StatelessWidget {
  final TestSuiteDetailState state;

  const TabSection(this.state);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 32, bottom: 32, left: 32),
      child: CustomTabs(
        tabs: const [
          TabItem(title: 'History', width: 150, icon: Icons.history),
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
