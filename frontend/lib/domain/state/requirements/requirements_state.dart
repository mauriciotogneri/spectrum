import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:testflow/debug/data.dart';
import 'package:testflow/domain/model/requirement.dart';
import 'package:testflow/domain/types/requirement_importance.dart';
import 'package:testflow/domain/types/requirement_status.dart';
import 'package:testflow/domain/types/requirement_type.dart';
import 'package:testflow/presentation/common/dropdown/dropdown_input_multiple.dart';
import 'package:testflow/presentation/common/input/text_input_field.dart';
import 'package:testflow/presentation/dialogs/create_requirement_dialog.dart';

class RequirementsState extends BaseState {
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

  void onRequirementSelected(Requirement requirement) {
    print(requirement);
  }

  void onCreateRequirement(BuildContext context) => showShadDialog(
        context: context,
        builder: (context) => CreateRequirementDialog.instance(
          onCreateRequirement: createRequirement,
        ),
      );

  void createRequirement({
    required String id,
    required String name,
    required String description,
  }) {}
}
