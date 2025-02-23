import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:testflow/debug/data.dart';
import 'package:testflow/domain/model/suite.dart';
import 'package:testflow/domain/types/requirement_importance.dart';
import 'package:testflow/domain/types/requirement_type.dart';
import 'package:testflow/extensions/build_context_extension.dart';
import 'package:testflow/presentation/common/input/custom_dropdown_multiple.dart';
import 'package:testflow/presentation/common/input/custom_text_input.dart';
import 'package:testflow/presentation/dialogs/base_dialog.dart';
import 'package:testflow/presentation/dialogs/create_suite_dialog.dart';

class SuiteListState extends BaseState {
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
  final List<Suite> _allSuites = Data.suites();

  SuiteListState({required this.projectId});

  List<Suite> get suites =>
      _allSuites
          .where(
            (suite) => suite.matches(
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

  void onSuiteSelected({
    required BuildContext context,
    required String suiteId,
  }) => context.suiteDetail(projectId: projectId, suiteId: suiteId);

  void onCreateSuite(BuildContext context) => BaseDialog.show(
    context: context,
    dialog: CreateSuiteDialog.instance(onCreateSuite: _createSuite),
  );

  void _createSuite({
    required String name,
    required List<RequirementType> types,
    required List<RequirementImportance> importances,
    required List<String> components,
    required List<String> platforms,
  }) {
    Data.createSuite(
      name: name,
      types: types,
      importances: importances,
      components: components,
      platforms: platforms,
    );
    notify();
  }
}
