import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:testflow/debug/data.dart';
import 'package:testflow/domain/model/test_suite.dart';
import 'package:testflow/domain/types/requirement_importance.dart';
import 'package:testflow/domain/types/requirement_type.dart';
import 'package:testflow/extensions/build_context_extension.dart';
import 'package:testflow/presentation/common/input/custom_dropdown_multiple.dart';
import 'package:testflow/presentation/common/input/custom_text_input.dart';
import 'package:testflow/presentation/dialogs/base_dialog.dart';
import 'package:testflow/presentation/dialogs/create_test_suite_dialog.dart';

class TestSuiteListState extends BaseState {
  final String projectId;
  final CustomTextInputController queryFilterController =
      CustomTextInputController();
  final CustomDropdownMultipleController<RequirementType> typeFilterController =
      CustomDropdownMultipleController();
  final CustomDropdownMultipleController<RequirementImportance>
  importanceFilterController = CustomDropdownMultipleController();
  final CustomDropdownMultipleController<String> componentFilterController =
      CustomDropdownMultipleController();
  final CustomDropdownMultipleController<String> platformFilterController =
      CustomDropdownMultipleController();

  TestSuiteListState({required this.projectId});

  List<TestSuite> get testSuites =>
      Data.testSuites()
          .where(
            (testSuite) => testSuite.matches(
              queryFilter: queryFilterController.text,
              typeFilter: typeFilterController.selected,
              importanceFilter: importanceFilterController.selected,
              componentFilter: componentFilterController.selected,
              platformFilter: platformFilterController.selected,
            ),
          )
          .toList();

  bool get hasFilters =>
      queryFilterController.isNotEmpty ||
      typeFilterController.isNotEmpty ||
      importanceFilterController.isNotEmpty ||
      componentFilterController.isNotEmpty ||
      platformFilterController.isNotEmpty;

  void onResetFilters() {
    queryFilterController.clear();
    typeFilterController.clear();
    importanceFilterController.clear();
    componentFilterController.clear();
    platformFilterController.clear();
    notify();
  }

  void onTestSuiteSelected({
    required BuildContext context,
    required String testSuiteId,
  }) => context.testSuiteDetail(projectId: projectId, testSuiteId: testSuiteId);

  void onCreateTestSuite(BuildContext context) => BaseDialog.show(
    context: context,
    dialog: CreateTestSuiteDialog.instance(onCreateTestSuite: _createTestSuite),
  );

  void _createTestSuite({
    required String name,
    required List<RequirementType> types,
    required List<RequirementImportance> importances,
    required List<String> components,
    required List<String> platforms,
  }) {
    Data.createTestSuite(
      name: name,
      types: types,
      importances: importances,
      components: components,
      platforms: platforms,
    );
    notify();
  }

  void onTableMenuSelected({
    required BuildContext context,
    required TestSuite testSuite,
    required TestSuiteMenu menu,
  }) {}
}
