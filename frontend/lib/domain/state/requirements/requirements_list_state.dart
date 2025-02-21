import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:testflow/debug/data.dart';
import 'package:testflow/domain/model/requirement.dart';
import 'package:testflow/domain/types/requirement_importance.dart';
import 'package:testflow/domain/types/requirement_status.dart';
import 'package:testflow/domain/types/requirement_type.dart';
import 'package:testflow/presentation/common/input/custom_dropdown_multiple.dart';
import 'package:testflow/presentation/common/input/custom_text_input.dart';
import 'package:testflow/presentation/dialogs/base_dialog.dart';
import 'package:testflow/presentation/dialogs/create_requirement_dialog.dart';
import 'package:testflow/utils/navigation.dart';

class RequirementsListState extends BaseState {
  final String projectId;
  final CustomTextInputController queryFilterController =
      CustomTextInputController();
  final CustomDropdownMultipleController<RequirementType> typeFilterController =
      CustomDropdownMultipleController();
  final CustomDropdownMultipleController<RequirementStatus>
  statusFilterController = CustomDropdownMultipleController();
  final CustomDropdownMultipleController<String> componentFilterController =
      CustomDropdownMultipleController();
  final CustomDropdownMultipleController<String> platformFilterController =
      CustomDropdownMultipleController();
  final CustomDropdownMultipleController<RequirementImportance>
  importanceFilterController = CustomDropdownMultipleController();
  final List<Requirement> _allRequirements = Data.requirements();

  RequirementsListState({required this.projectId});

  List<Requirement> get requirements =>
      _allRequirements
          .where(
            (requirement) => requirement.matches(
              queryFilter: queryFilterController.text,
              typeFilter: typeFilterController.selected,
              statusFilter: statusFilterController.selected,
              componentFilter: componentFilterController.selected,
              platformFilter: platformFilterController.selected,
              importanceFilter: importanceFilterController.selected,
            ),
          )
          .toList();

  bool get hasFilters =>
      queryFilterController.isNotEmpty ||
      typeFilterController.isNotEmpty ||
      statusFilterController.isNotEmpty ||
      componentFilterController.isNotEmpty ||
      platformFilterController.isNotEmpty ||
      importanceFilterController.isNotEmpty;

  void onResetFilters() {
    queryFilterController.clear();
    typeFilterController.clear();
    statusFilterController.clear();
    componentFilterController.clear();
    platformFilterController.clear();
    importanceFilterController.clear();
    notify();
  }

  void onRequirementSelected({
    required BuildContext context,
    required String requirementId,
  }) => Navigation.requirementDetails(
    context: context,
    projectId: projectId,
    requirementId: requirementId,
  );

  void onCreateRequirement(BuildContext context) => BaseDialog.show(
    context: context,
    dialog: CreateRequirementDialog.instance(
      onCreateRequirement: _createRequirement,
    ),
  );

  void _createRequirement({
    required String name,
    required String description,
    required String id,
    required RequirementType type,
    required RequirementStatus status,
    required RequirementImportance importance,
    required String component,
    required List<String> platforms,
  }) {
    Data.onCreateRequirement(
      name: name,
      description: description,
      id: id,
      type: type,
      status: status,
      importance: importance,
      component: component,
      platforms: platforms,
    );
    notify();
  }
}
