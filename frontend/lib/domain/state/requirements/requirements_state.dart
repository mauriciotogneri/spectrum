import 'package:dafluta/dafluta.dart';
import 'package:testflow/debug/data.dart';
import 'package:testflow/domain/model/requirement.dart';
import 'package:testflow/domain/types/importance.dart';
import 'package:testflow/domain/types/requirement_type.dart';
import 'package:testflow/presentation/common/dropdown/dropdown_input.dart';
import 'package:testflow/presentation/common/input/text_input_field.dart';

class RequirementsState extends BaseState {
  final TextInputController queryFilterController = TextInputController();
  final DropdownInputController<RequirementType> typeFilterController =
      DropdownInputController();
  final DropdownInputController<String> componentFilterController =
      DropdownInputController();
  final DropdownInputController<String> platformFilterController =
      DropdownInputController();
  final DropdownInputController<Importance> importanceFilterController =
      DropdownInputController();
  final List<Requirement> _allRequirements = Data.requirements();

  List<Requirement> get requirements => _allRequirements
      .where((requirement) => requirement.matches(
            queryFilter: queryFilterController.text,
            typeFilter: typeFilterController.selected,
            componentFilter: componentFilterController.selected,
            platformFilter: platformFilterController.selected,
            importanceFilter: importanceFilterController.selected,
          ))
      .toList();

  void onQueryFilterChanged(String value) {
    notify();
  }

  void onTypeFilterChanged(List<RequirementType> values) {
    typeFilterController.onChanged(values);
    notify();
  }

  void onComponentFilterChanged(List<String> values) {
    componentFilterController.onChanged(values);
    notify();
  }

  void onPlatformFilterChanged(List<String> values) {
    platformFilterController.onChanged(values);
    notify();
  }

  void onImportanceFilterChanged(List<Importance> values) {
    importanceFilterController.onChanged(values);
    notify();
  }

  void onRequirementSelected(Requirement requirement) {
    print(requirement);
  }
}
