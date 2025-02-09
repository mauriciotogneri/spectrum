import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:testflow/debug/data.dart';
import 'package:testflow/domain/model/requirement.dart';
import 'package:testflow/domain/state/requirements/requirement_details_state.dart';
import 'package:testflow/domain/types/requirement_importance.dart';
import 'package:testflow/domain/types/requirement_status.dart';
import 'package:testflow/domain/types/requirement_type.dart';
import 'package:testflow/presentation/common/dropdown/dropdown_input_multiple.dart';
import 'package:testflow/presentation/common/dropdown/dropdown_input_single.dart';
import 'package:testflow/presentation/common/input/text_input_field.dart';
import 'package:testflow/presentation/common/text/input_label.dart';
import 'package:testflow/presentation/common/text/title_4.dart';
import 'package:testflow/presentation/common/view/base_view.dart';

class RequirementDetailView extends StatelessWidget {
  final RequirementDetailsState state;

  const RequirementDetailView._(this.state);

  factory RequirementDetailView.instance({
    required Requirement requirement,
  }) =>
      RequirementDetailView._(
          RequirementDetailsState(requirement: requirement));

  @override
  Widget build(BuildContext context) {
    return StateProvider<RequirementDetailsState>(
      state: state,
      builder: (context, state) => BaseView.withBack(
        header: Title4(text: 'Requirement: ${state.requirement.name}'),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FormFields(state),
          ],
        ),
      ),
    );
  }
}

class FormFields extends StatelessWidget {
  final RequirementDetailsState state;

  const FormFields(this.state);

  @override
  Widget build(BuildContext context) {
    return ShadForm(
      key: state.formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const InputLabel('Name'),
                    TextInputField(
                      hint: 'Name',
                      isForm: true,
                      autofocus: true,
                      controller: state.nameController,
                      errorMessage: 'Name is required',
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const InputLabel('ID'),
                    TextInputField(
                      hint: 'ID',
                      isForm: true,
                      controller: state.idController,
                      errorMessage: 'ID is required',
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const InputLabel('Type'),
                    DropdownInputSingle<RequirementType>(
                      width: 240,
                      values: RequirementType.values,
                      controller: state.typeController,
                      allowDeselection: true,
                      isForm: true,
                      hint: 'Type',
                      errorMessage: 'Type is required',
                    ),
                  ],
                ),
              ),
            ],
          ),
          const InputLabel('Description'),
          TextInputField(
            hint: 'Description',
            isForm: true,
            maxLines: 5,
            controller: state.descriptionController,
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const InputLabel('Status'),
                    DropdownInputSingle<RequirementStatus>(
                      width: 240,
                      values: RequirementStatus.values,
                      controller: state.statusController,
                      allowDeselection: true,
                      isForm: true,
                      hint: 'Status',
                      errorMessage: 'Status is required',
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const InputLabel('Importance'),
                    DropdownInputSingle<RequirementImportance>(
                      width: 240,
                      values: RequirementImportance.values,
                      controller: state.importanceController,
                      allowDeselection: true,
                      isForm: true,
                      hint: 'Importance',
                      errorMessage: 'Importance is required',
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const InputLabel('Component'),
                    DropdownInputSingle<String>(
                      width: 240,
                      values: Data.currentProject.components,
                      controller: state.componentController,
                      allowDeselection: true,
                      isForm: true,
                      hint: 'Component',
                      errorMessage: 'Component is required',
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const InputLabel('Platforms'),
                    DropdownInputMultiple<String>(
                      width: 240,
                      values: Data.currentProject.platforms,
                      controller: state.platformsController,
                      allowDeselection: true,
                      isForm: true,
                      hint: 'Platforms',
                      errorMessage: 'Platforms is required',
                    ),
                  ],
                ),
              ),
            ],
          ),
          const VBox(16),
        ],
      ),
    );
  }
}
