import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:testflow/domain/model/requirement.dart';
import 'package:testflow/domain/model/test_case.dart';
import 'package:testflow/presentation/common/input/text_input_field.dart';

class TestCaseDetailsState extends BaseState {
  final Requirement requirement;
  final TestCase testCase;
  final GlobalKey<ShadFormState> formKey = GlobalKey();
  final TextInputController nameController = TextInputController();
  final TextInputController preconditionsController = TextInputController();
  final TextInputController stepsController = TextInputController();
  final TextInputController expectedController = TextInputController();

  bool get formValid => formKey.currentState!.validate();

  TestCaseDetailsState({
    required this.requirement,
    required this.testCase,
  }) {
    nameController.text = testCase.name;
    preconditionsController.text = testCase.preconditions;
    stepsController.text = testCase.steps;
    expectedController.text = testCase.expected;
  }
}
