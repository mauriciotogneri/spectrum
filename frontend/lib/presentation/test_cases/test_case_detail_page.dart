import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:testflow/domain/state/test_cases/test_case_detail_state.dart';
import 'package:testflow/domain/types/test_case_execution.dart';
import 'package:testflow/presentation/common/card/metadata_card.dart';
import 'package:testflow/presentation/common/input/custom_dropdown_single.dart';
import 'package:testflow/presentation/common/input/custom_multiline_input.dart';
import 'package:testflow/presentation/common/input/custom_text_input.dart';
import 'package:testflow/presentation/common/layout/pane.dart';
import 'package:testflow/presentation/common/menu/context_menu.dart';
import 'package:testflow/presentation/common/navigation/navigation_path.dart';
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
            path: Navigation.requirementListPath(state.projectId),
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
          icon: Icons.more_horiz,
          children: [
            ContextMenuItem(
              icon: Icons.delete_outline,
              text: 'Delete',
              color: Palette.semanticError,
              onPressed: state.onDeleteTestCase,
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
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: FormFields(state)),
        const Metadata(),
        const HBox(32),
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
      padding: const EdgeInsets.all(32),
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
            CustomMultilineInput(
              minLines: 5,
              maxLines: 5,
              name: 'Preconditions',
              controller: state.preconditionsController,
            ),
            const VBox(16),
            CustomTextInput(
              minLines: 5,
              maxLines: 5,
              name: 'Steps',
              controller: state.stepsController,
            ),
            const VBox(16),
            CustomTextInput(
              minLines: 5,
              maxLines: 5,
              name: 'Expected result',
              controller: state.expectedController,
            ),
            const VBox(16),
          ],
        ),
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
      MetadataItem(
        label: 'Last run',
        value:
            '${Formatter.fullDateTime(DateTime.now())}\n${Formatter.daysAgo(DateTime.now())} days ago',
      ),
    ]);
  }
}
