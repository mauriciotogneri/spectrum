import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:testflow/debug/data.dart';
import 'package:testflow/domain/model/requirement.dart';
import 'package:testflow/domain/model/test_case.dart';
import 'package:testflow/domain/types/requirement_importance.dart';
import 'package:testflow/domain/types/requirement_status.dart';
import 'package:testflow/domain/types/requirement_type.dart';
import 'package:testflow/presentation/common/input/custom_dropdown_multiple.dart';
import 'package:testflow/presentation/common/input/custom_dropdown_single.dart';
import 'package:testflow/presentation/common/input/custom_text_input.dart';

class RequirementDetailsState extends BaseState {
  final Requirement requirement;
  final List<TestCase> testCases = [];
  final GlobalKey<FormState> formKey = GlobalKey();
  final CustomTextInputController idController = CustomTextInputController();
  final CustomDropdownSingleController<RequirementType> typeController =
      CustomDropdownSingleController();
  final CustomTextInputController nameController = CustomTextInputController();
  final CustomTextInputController descriptionController =
      CustomTextInputController();
  final CustomDropdownSingleController<RequirementStatus> statusController =
      CustomDropdownSingleController();
  final CustomDropdownSingleController<RequirementImportance>
  importanceController = CustomDropdownSingleController();
  final CustomDropdownSingleController<String> componentController =
      CustomDropdownSingleController();
  final CustomDropdownMultipleController<String> platformsController =
      CustomDropdownMultipleController();
  TestCase? selectedTestCase;

  bool get formValid => formKey.currentState!.validate();

  RequirementDetailsState({required this.requirement}) {
    idController.text = requirement.id;
    typeController.select(requirement.type);
    nameController.text = requirement.name;
    descriptionController.text = requirement.description;
    statusController.select(requirement.status);
    importanceController.select(requirement.importance);
    componentController.select(requirement.component);
    platformsController.select(requirement.platforms);

    testCases.addAll(Data.testCases(requirement));
  }

  void onTestCaseSelected(TestCase testCase) {
    selectedTestCase = testCase;
    notify();
  }
}
