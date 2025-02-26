import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:testflow/domain/state/test_runs/test_run_detail_state.dart';
import 'package:testflow/domain/types/test_run_reproducibility.dart';
import 'package:testflow/domain/types/test_run_result.dart';
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

class TestRunDetailPage extends StatelessWidget {
  final TestRunDetailState state;

  const TestRunDetailPage._(this.state);

  factory TestRunDetailPage.instance({
    required String projectId,
    required String testSessionId,
    required String testRunId,
  }) => TestRunDetailPage._(
    TestRunDetailState(
      projectId: projectId,
      sessionId: testSessionId,
      testRunId: testRunId,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return StateProvider<TestRunDetailState>(
      state: state,
      builder: (context, state) => Content(state),
    );
  }
}

class Content extends StatelessWidget {
  final TestRunDetailState state;

  const Content(this.state);

  @override
  Widget build(BuildContext context) {
    return Pane.scrollable(children: [Header(state), Body(state)]);
  }
}

class Header extends StatelessWidget {
  final TestRunDetailState state;

  const Header(this.state);

  @override
  Widget build(BuildContext context) {
    return PaneHeader(
      path: NavigationPath(
        paths: [
          PathItem(
            text: 'Sessions',
            path: Navigation.testSessionListPath(projectId: state.projectId),
          ),
          PathItem(
            text: state.testSession.name,
            path: Navigation.testSessionDetailPath(
              projectId: state.projectId,
              testSessionId: state.testSession.id,
            ),
          ),
          PathItem(text: state.testRun.name),
        ],
      ),
      actions: [
        ContextMenu(
          type: ContextButton.iconButton,
          offset: const Offset(-65, 0),
          icon: Icons.more_horiz,
          children: [
            ContextMenuItem(
              icon: Icons.delete_outline,
              text: 'Delete',
              color: Palette.semanticError,
              onPressed: () => state.onDeleteTestRun(context),
            ),
          ],
        ),
      ],
    );
  }
}

class Body extends StatelessWidget {
  final TestRunDetailState state;

  const Body(this.state);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: FormFields(state)),
        Metadata(state),
        const HBox(32),
      ],
    );
  }
}

class FormFields extends StatelessWidget {
  final TestRunDetailState state;

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
                CustomDropdownSingle<TestRunResult>(
                  width: 150,
                  name: 'Result',
                  values: TestRunResult.items,
                  controller: state.resultController,
                  errorMessage: 'Result is required',
                ),
                const HBox(16),
                CustomDropdownSingle<TestRunReproducibility>(
                  width: 150,
                  name: 'Reproducibility',
                  values: TestRunReproducibility.items,
                  controller: state.reproducibilityController,
                  errorMessage: 'Reproducibility is required',
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
                    enabled: false,
                    controller: state.preconditionsController,
                  ),
                ),
                const HBox(16),
                Expanded(
                  child: CustomMultilineInput(
                    minLines: 6,
                    maxLines: 6,
                    name: 'Steps',
                    enabled: false,
                    controller: state.stepsController,
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
                    minLines: 6,
                    maxLines: 6,
                    name: 'Expected result',
                    enabled: false,
                    controller: state.expectedController,
                  ),
                ),
                const HBox(16),
                Expanded(
                  child: CustomMultilineInput(
                    minLines: 6,
                    maxLines: 6,
                    name: 'Actual result',
                    controller: state.actualController,
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
  final TestRunDetailState state;

  const Metadata(this.state);

  @override
  Widget build(BuildContext context) {
    return MetadataCard([
      MetadataItem(
        label: 'Created on',
        value: Formatter.dateMonthYear(state.testRun.createdOn),
        tooltip: Formatter.fullDateTime(state.testRun.createdOn),
      ),
      MetadataItem(label: 'Created by', value: state.testRun.createdBy),
      MetadataItem(
        label: 'Updated on',
        value: Formatter.dateMonthYear(state.testRun.updatedOn),
        tooltip: Formatter.fullDateTime(state.testRun.updatedOn),
      ),
      MetadataItem(label: 'Updated by', value: state.testRun.updatedBy),
    ]);
  }
}
