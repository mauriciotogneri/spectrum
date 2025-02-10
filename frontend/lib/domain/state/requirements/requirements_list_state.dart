import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:testflow/debug/data.dart';
import 'package:testflow/domain/model/requirement.dart';
import 'package:testflow/domain/types/requirement_importance.dart';
import 'package:testflow/domain/types/requirement_status.dart';
import 'package:testflow/domain/types/requirement_type.dart';
import 'package:testflow/presentation/common/dropdown/dropdown_input_multiple.dart';
import 'package:testflow/presentation/common/input/text_input_field.dart';
import 'package:testflow/presentation/dialogs/base_dialog.dart';
import 'package:testflow/presentation/dialogs/create_requirement_dialog.dart';
import 'package:testflow/presentation/requirements/requirement_details_view.dart';
import 'package:testflow/utils/navigation.dart';

class RequirementsListState extends BaseState {
  final TextInputController queryFilterController = TextInputController();
  final DropdownInputMultipleController<RequirementType> typeFilterController =
      DropdownInputMultipleController();
  final DropdownInputMultipleController<RequirementStatus>
      statusFilterController = DropdownInputMultipleController();
  final DropdownInputMultipleController<String> componentFilterController =
      DropdownInputMultipleController();
  final DropdownInputMultipleController<String> platformFilterController =
      DropdownInputMultipleController();
  final DropdownInputMultipleController<RequirementImportance>
      importanceFilterController = DropdownInputMultipleController();
  final List<Requirement> _allRequirements = Data.requirements();

  List<Requirement> get requirements => _allRequirements
      .where((requirement) => requirement.matches(
            queryFilter: queryFilterController.text,
            typeFilter: typeFilterController.selected,
            statusFilter: statusFilterController.selected,
            componentFilter: componentFilterController.selected,
            platformFilter: platformFilterController.selected,
            importanceFilter: importanceFilterController.selected,
          ))
      .toList();

  void onRequirementSelected(Requirement requirement) =>
      Navigation.stack(RequirementDetailsView.instance(
        requirement: requirement,
      ));

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
