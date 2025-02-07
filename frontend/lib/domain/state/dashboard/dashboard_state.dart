import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:testflow/presentation/dialogs/create_project_dialog.dart';

class DashboardState extends BaseState {
  int activeView = 0;

  static const int VIEW_REQUIREMENTS = 0;
  static const int VIEW_SUITES = 1;
  static const int VIEW_SESSIONS = 2;
  static const int VIEW_SETTINGS = 3;

  void onActiveViewChange(int index) {
    activeView = index;
    notify();
  }

  void onCreateProject(BuildContext context) => showShadDialog(
        context: context,
        builder: (context) => CreateProjectDialog(
          onCreate: createProject,
        ),
      );

  void createProject({
    required String name,
    required String description,
  }) {}
}
