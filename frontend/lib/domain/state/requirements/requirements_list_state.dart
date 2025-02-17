import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:testflow/debug/data.dart';
import 'package:testflow/domain/model/requirement.dart';
import 'package:testflow/domain/types/requirement_importance.dart';
import 'package:testflow/domain/types/requirement_status.dart';
import 'package:testflow/domain/types/requirement_type.dart';
import 'package:testflow/presentation/common/input/custom_dropdown_single.dart';
import 'package:testflow/presentation/common/input/custom_text_input.dart';
import 'package:testflow/presentation/dialogs/base_dialog.dart';
import 'package:testflow/presentation/dialogs/create_requirement_dialog.dart';

class RequirementsListState extends BaseState {
  final CustomTextInputController queryFilterController =
      CustomTextInputController();
  final CustomDropdownSingleController<RequirementType> typeFilterController =
      CustomDropdownSingleController();
  final CustomDropdownSingleController<RequirementStatus>
  statusFilterController = CustomDropdownSingleController();
  final CustomDropdownSingleController<String> componentFilterController =
      CustomDropdownSingleController();
  final CustomDropdownSingleController<String> platformFilterController =
      CustomDropdownSingleController();
  final CustomDropdownSingleController<RequirementImportance>
  importanceFilterController = CustomDropdownSingleController();
  final List<Requirement> _allRequirements = Data.requirements();

  List<Requirement> get requirements =>
      _allRequirements
          .where(
            (requirement) => requirement.matches(
              queryFilter: queryFilterController.text,
              typeFilter:
                  typeFilterController.isNotEmpty
                      ? [typeFilterController.selected!]
                      : [],
              statusFilter: [], //statusFilterController.selected
              componentFilter: [], //componentFilterController.selected
              platformFilter: [], //platformFilterController.selected
              importanceFilter: [], //importanceFilterController.selected
            ),
          )
          .toList();

  void onRequirementSelected(Requirement requirement) {
    print('Selected requirement: $requirement');
  }
  /*Navigation.stack(
    RequirementDetailsView.instance(requirement: requirement),
  );*/

  void onResetFilters() {
    queryFilterController.clear();
    typeFilterController.clear();
    statusFilterController.clear();
    componentFilterController.clear();
    platformFilterController.clear();
    importanceFilterController.clear();
    notify();
  }

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
