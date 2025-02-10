import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:testflow/domain/model/requirement.dart';
import 'package:testflow/domain/model/test_case.dart';
import 'package:testflow/domain/state/test_cases/test_case_details_state.dart';
import 'package:testflow/presentation/common/input/text_input_field.dart';
import 'package:testflow/presentation/common/text/input_label.dart';
import 'package:testflow/presentation/common/text/title_4.dart';
import 'package:testflow/presentation/common/view/base_view.dart';
import 'package:testflow/utils/palette.dart';

class TestCaseDetailsView extends StatelessWidget {
  final TestCaseDetailsState state;

  const TestCaseDetailsView._(this.state);

  factory TestCaseDetailsView.instance({
    required Requirement requirement,
    required TestCase testCase,
  }) =>
      TestCaseDetailsView._(TestCaseDetailsState(
        requirement: requirement,
        testCase: testCase,
      ));

  @override
  Widget build(BuildContext context) {
    return StateProvider<TestCaseDetailsState>(
      state: state,
      builder: (context, state) => BaseView.withBack(
        header: const Title4(text: 'Test case details'),
        content: FormFields(state),
      ),
    );
  }
}

class FormFields extends StatelessWidget {
  final TestCaseDetailsState state;

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
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              InputEntry(
                width: 840,
                label: 'Name',
                input: TextInputField(
                  isForm: true,
                  controller: state.nameController,
                  errorMessage: 'Name is required',
                ),
              ),
              const HBox(16),
              InputEntry(
                input: Padding(
                  padding: const EdgeInsets.only(
                    bottom: 8,
                  ),
                  child: ShadSwitch(
                    value: state.testCase.isAutomated,
                    padding: const EdgeInsets.only(
                      top: 0,
                      bottom: 0,
                      left: 8,
                      right: 0,
                    ),
                    label: const Text(
                      'Automated',
                      style: TextStyle(
                        color: Palette.textEnabled,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    enabled: false,
                  ),
                ),
              ),
            ],
          ),
          InputEntry(
            width: 1000,
            label: 'Preconditions',
            input: TextInputField(
              isForm: true,
              maxLines: 5,
              controller: state.preconditionsController,
            ),
          ),
          InputEntry(
            width: 1000,
            label: 'Steps',
            input: TextInputField(
              isForm: true,
              maxLines: 5,
              controller: state.stepsController,
            ),
          ),
          InputEntry(
            width: 1000,
            label: 'Expected result',
            input: TextInputField(
              isForm: true,
              maxLines: 5,
              controller: state.expectedController,
            ),
          ),
          const VBox(16),
        ],
      ),
    );
  }
}

class InputEntry extends StatelessWidget {
  final double? width;
  final String? label;
  final Widget input;

  const InputEntry({
    required this.input,
    this.label,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (label != null) InputLabel(label!),
          input,
        ],
      ),
    );
  }
}
