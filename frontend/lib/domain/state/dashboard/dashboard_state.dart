import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:testflow/debug/data.dart';
import 'package:testflow/domain/model/project.dart';
import 'package:testflow/presentation/common/dropdown/dropdown_input_single.dart';
import 'package:testflow/presentation/dialogs/create_project_dialog.dart';

class DashboardState extends BaseState {
  int activeView = 0;
  final DropdownInputSingleController<Project> projectsController =
      DropdownInputSingleController();

  static const int VIEW_REQUIREMENTS = 0;
  static const int VIEW_SUITES = 1;
  static const int VIEW_SESSIONS = 2;
  static const int VIEW_SETTINGS = 3;

  @override
  void onLoad() {
    projectsController.onChange(Data.currentProject);
    notify();
  }

  void onActiveViewChange(int index) {
    activeView = index;
    notify();
  }

  void onChangeProject(Project project) {
    Data.onChangeProject(project);
  }

  void onCreateProject(BuildContext context) {
    projectsController.close();

    showShadDialog(
      context: context,
      builder: (context) => CreateProjectDialog.instance(
        onCreateProject: createProject,
      ),
    );
  }

  void createProject({
    required String name,
    required String description,
  }) {
    Data.onCreateProject(Project(
      id: '',
      name: name,
      description: description,
      components: [],
      platforms: [],
    ));
    notify();
  }
}
