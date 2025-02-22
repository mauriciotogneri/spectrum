import 'package:dafluta/dafluta.dart';
import 'package:testflow/debug/data.dart';
import 'package:testflow/domain/model/requirement.dart';
import 'package:testflow/domain/model/test_case.dart';
import 'package:testflow/domain/types/test_case_execution.dart';
import 'package:testflow/presentation/common/form/form_key.dart';
import 'package:testflow/presentation/common/input/custom_dropdown_single.dart';
import 'package:testflow/presentation/common/input/custom_text_input.dart';

class TestCaseDetailsState extends BaseState {
  final String projectId;
  final String requirementId;
  final String testCaseId;
  Requirement? _requirement;
  TestCase? _testCase;

  final FormKey formKey = FormKey();
  final CustomTextInputController nameController = CustomTextInputController();
  final CustomDropdownSingleController<TestCaseExecution> executionController =
      CustomDropdownSingleController();
  final CustomTextInputController preconditionsController =
      CustomTextInputController();
  final CustomTextInputController stepsController = CustomTextInputController();
  final CustomTextInputController expectedController =
      CustomTextInputController();

  TestCaseDetailsState({
    required this.projectId,
    required this.requirementId,
    required this.testCaseId,
  });

  Requirement get requirement => _requirement!;

  TestCase get testCase => _testCase!;

  bool get isLoading => (_requirement == null) || (_testCase == null);

  @override
  void onLoad() {
    _requirement = Data.requirementById(requirementId);
    _testCase = Data.testCaseById(testCaseId);

    nameController.text = testCase.name;
    executionController.select(testCase.execution);
    preconditionsController.text = testCase.preconditions;
    stepsController.text = testCase.steps;
    expectedController.text = testCase.expected;

    notify();
  }
}
