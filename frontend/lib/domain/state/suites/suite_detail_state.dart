import 'package:dafluta/dafluta.dart';
import 'package:testflow/debug/data.dart';
import 'package:testflow/domain/model/suite.dart';
import 'package:testflow/domain/types/requirement_importance.dart';
import 'package:testflow/domain/types/requirement_status.dart';
import 'package:testflow/domain/types/requirement_type.dart';
import 'package:testflow/presentation/common/form/form_key.dart';
import 'package:testflow/presentation/common/input/custom_dropdown_multiple.dart';
import 'package:testflow/presentation/common/input/custom_text_input.dart';

class SuiteDetailState extends BaseState {
  final String projectId;
  final String suiteId;
  Suite? _suite;
  final FormKey formKey = FormKey();
  final CustomTextInputController nameController = CustomTextInputController();
  final CustomDropdownMultipleController<RequirementType> typeController =
      CustomDropdownMultipleController();
  final CustomDropdownMultipleController<RequirementStatus> statusController =
      CustomDropdownMultipleController();
  final CustomDropdownMultipleController<RequirementImportance>
  importanceController = CustomDropdownMultipleController();
  final CustomDropdownMultipleController<String> componentController =
      CustomDropdownMultipleController();
  final CustomDropdownMultipleController<String> platformsController =
      CustomDropdownMultipleController();

  SuiteDetailState({required this.projectId, required this.suiteId});

  Suite get suite => _suite!;

  bool get isLoading => _suite == null;

  @override
  void onLoad() {
    _suite = Data.suiteById(suiteId);

    nameController.text = suite.name;
    typeController.select(suite.types);
    statusController.select(suite.statuses);
    importanceController.select(suite.importances);
    componentController.select(suite.components);
    platformsController.select(suite.platforms);
    notify();
  }

  void onDeleteSuite() {}
}
