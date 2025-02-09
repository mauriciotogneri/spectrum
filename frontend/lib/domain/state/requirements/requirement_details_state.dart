import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:testflow/domain/model/requirement.dart';
import 'package:testflow/domain/types/requirement_importance.dart';
import 'package:testflow/domain/types/requirement_status.dart';
import 'package:testflow/domain/types/requirement_type.dart';
import 'package:testflow/presentation/common/dropdown/dropdown_input_multiple.dart';
import 'package:testflow/presentation/common/dropdown/dropdown_input_single.dart';
import 'package:testflow/presentation/common/input/text_input_field.dart';

class RequirementDetailsState extends BaseState {
  final Requirement requirement;
  final GlobalKey<ShadFormState> formKey = GlobalKey();
  final TextInputController idController = TextInputController();
  final DropdownInputSingleController<RequirementType> typeController =
      DropdownInputSingleController();
  final TextInputController nameController = TextInputController();
  final TextInputController descriptionController = TextInputController();
  final DropdownInputSingleController<RequirementStatus> statusController =
      DropdownInputSingleController();
  final DropdownInputSingleController<RequirementImportance>
      importanceController = DropdownInputSingleController();
  final DropdownInputSingleController<String> componentController =
      DropdownInputSingleController();
  final DropdownInputMultipleController<String> platformsController =
      DropdownInputMultipleController();

  bool get formValid => formKey.currentState!.validate();

  RequirementDetailsState({required this.requirement});
}
