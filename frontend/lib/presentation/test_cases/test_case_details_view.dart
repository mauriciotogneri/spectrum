import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:testflow/domain/model/requirement.dart';
import 'package:testflow/domain/model/test_case.dart';
import 'package:testflow/domain/state/test_cases/test_case_details_state.dart';
import 'package:testflow/domain/types/test_case_execution.dart';
import 'package:testflow/presentation/common/input/custom_dropdown_single.dart';
import 'package:testflow/presentation/common/input/custom_multiline_input.dart';
import 'package:testflow/presentation/common/input/custom_text_input.dart';
import 'package:testflow/presentation/common/layout/pane.dart';
import 'package:testflow/presentation/common/navigation/navigation_path.dart';

class TestCaseDetailsView extends StatelessWidget {
  final TestCaseDetailsState state;

  const TestCaseDetailsView._(this.state);

  factory TestCaseDetailsView.instance({
    required Requirement requirement,
    required TestCase testCase,
  }) => TestCaseDetailsView._(
    TestCaseDetailsState(requirement: requirement, testCase: testCase),
  );

  @override
  Widget build(BuildContext context) {
    return StateProvider<TestCaseDetailsState>(
      state: state,
      builder:
          (context, state) => Pane.scrollable(
            children: [
              const NavigationPath('Test case details'),
              FormFields(state),
            ],
          ),
    );
  }
}

class FormFields extends StatelessWidget {
  final TestCaseDetailsState state;

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
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextInput(
                  width: 835,
                  name: 'Name',
                  controller: state.nameController,
                  errorMessage: 'Name is required',
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
              width: 1000,
              minLines: 5,
              maxLines: 5,
              name: 'Preconditions',
              controller: state.preconditionsController,
            ),
            const VBox(16),
            CustomTextInput(
              width: 1000,
              minLines: 5,
              maxLines: 5,
              name: 'Steps',
              controller: state.stepsController,
            ),
            const VBox(16),
            CustomTextInput(
              width: 1000,
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
