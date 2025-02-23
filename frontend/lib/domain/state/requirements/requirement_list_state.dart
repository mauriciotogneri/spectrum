import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:testflow/debug/data.dart';
import 'package:testflow/domain/model/requirement.dart';
import 'package:testflow/domain/types/requirement_importance.dart';
import 'package:testflow/domain/types/requirement_status.dart';
import 'package:testflow/domain/types/requirement_type.dart';
import 'package:testflow/extensions/build_context_extension.dart';
import 'package:testflow/presentation/common/input/custom_dropdown_multiple.dart';
import 'package:testflow/presentation/common/input/custom_text_input.dart';
import 'package:testflow/presentation/dialogs/base_dialog.dart';
import 'package:testflow/presentation/dialogs/create_requirement_dialog.dart';

class RequirementListState extends BaseState {
  final String projectId;
  final CustomTextInputController queryFilterController =
      CustomTextInputController();
  final CustomDropdownMultipleController<RequirementType> typeFilterController =
      CustomDropdownMultipleController();
  final CustomDropdownMultipleController<RequirementStatus>
  statusFilterController = CustomDropdownMultipleController();
  final CustomDropdownMultipleController<RequirementImportance>
  importanceFilterController = CustomDropdownMultipleController();
  final CustomDropdownMultipleController<String> componentFilterController =
      CustomDropdownMultipleController();
  final CustomDropdownMultipleController<String> platformFilterController =
      CustomDropdownMultipleController();
  final List<Requirement> _allRequirements = Data.requirements();

  RequirementListState({required this.projectId});

  List<Requirement> get requirements =>
      _allRequirements
          .where(
            (requirement) => requirement.matches(
              queryFilter: queryFilterController.text,
              typeFilter: typeFilterController.selected,
              statusFilter: statusFilterController.selected,
              importanceFilter: importanceFilterController.selected,
              componentFilter: componentFilterController.selected,
              platformFilter: platformFilterController.selected,
            ),
          )
          .toList();

  bool get hasFilters =>
      queryFilterController.isNotEmpty ||
      typeFilterController.isNotEmpty ||
      statusFilterController.isNotEmpty ||
      importanceFilterController.isNotEmpty ||
      componentFilterController.isNotEmpty ||
      platformFilterController.isNotEmpty;

  void onResetFilters() {
    queryFilterController.clear();
    typeFilterController.clear();
    statusFilterController.clear();
    importanceFilterController.clear();
    componentFilterController.clear();
    platformFilterController.clear();
    notify();
  }

  void onRequirementSelected({
    required BuildContext context,
    required String requirementId,
  }) => context.requirementDetail(
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
    required String code,
    required String description,
    required RequirementType type,
    required RequirementStatus status,
    required RequirementImportance importance,
    required String component,
    required List<String> platforms,
  }) {
    Data.createRequirement(
      name: name,
      code: code,
      description: description,
      type: type,
      status: status,
      importance: importance,
      component: component,
      platforms: platforms,
    );
    notify();
  }
}
