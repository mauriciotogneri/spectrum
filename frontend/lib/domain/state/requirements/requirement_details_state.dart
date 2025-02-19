import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:testflow/debug/data.dart';
import 'package:testflow/domain/model/requirement.dart';
import 'package:testflow/domain/model/test_case.dart';
import 'package:testflow/domain/types/requirement_importance.dart';
import 'package:testflow/domain/types/requirement_status.dart';
import 'package:testflow/domain/types/requirement_type.dart';
import 'package:testflow/domain/types/test_case_execution.dart';
import 'package:testflow/presentation/common/input/custom_dropdown_multiple.dart';
import 'package:testflow/presentation/common/input/custom_dropdown_single.dart';
import 'package:testflow/presentation/common/input/custom_text_input.dart';
import 'package:testflow/presentation/test_cases/test_case_details_view.dart';
import 'package:testflow/utils/navigation.dart';

class RequirementDetailsState extends BaseState {
  final Requirement requirement;
  final List<TestCase> _allTestCases = [];
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

  final CustomTextInputController queryFilterController =
      CustomTextInputController();
  final CustomDropdownMultipleController<TestCaseExecution>
  executionFilterController = CustomDropdownMultipleController();

  List<TestCase> get testCases =>
      _allTestCases
          .where(
            (testCase) => testCase.matches(
              queryFilter: queryFilterController.text,
              executionFilter: executionFilterController.selected,
            ),
          )
          .toList();

  RequirementDetailsState({required this.requirement}) {
    idController.text = requirement.id;
    typeController.select(requirement.type);
    nameController.text = requirement.name;
    descriptionController.text = requirement.description;
    statusController.select(requirement.status);
    importanceController.select(requirement.importance);
    componentController.select(requirement.component);
    platformsController.select(requirement.platforms);

    _allTestCases.addAll(Data.testCases(requirement));
  }

  bool get hasFilters =>
      queryFilterController.isNotEmpty || executionFilterController.isNotEmpty;

  void onResetFilters() {
    queryFilterController.clear();
    executionFilterController.clear();
    notify();
  }

  void onTestCaseSelected(TestCase testCase) => Navigation.stack(
    TestCaseDetailsView.instance(requirement: requirement, testCase: testCase),
  );

  void onCreateTestCase(BuildContext context) {}
}
