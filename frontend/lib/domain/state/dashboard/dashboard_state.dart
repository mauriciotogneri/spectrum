import 'dart:async';

import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:testflow/debug/data.dart';
import 'package:testflow/domain/events/events.dart';
import 'package:testflow/domain/events/stack_view_event.dart';
import 'package:testflow/domain/events/unstack_view_event.dart';
import 'package:testflow/domain/model/project.dart';
import 'package:testflow/presentation/common/dropdown/dropdown_input_single.dart';
import 'package:testflow/presentation/dashboard/dashboard_screen.dart';
import 'package:testflow/presentation/dialogs/base_dialog.dart';
import 'package:testflow/presentation/dialogs/create_project_dialog.dart';
import 'package:testflow/presentation/requirements/requirements_view.dart';

class DashboardState extends BaseState {
  int activeView = 0;
  StreamSubscription? _subscriptionStackViewEvent;
  StreamSubscription? _subscriptionUnstackViewEvent;
  final DropdownInputSingleController<Project> projectsController =
      DropdownInputSingleController();
  final List<Widget> viewsStack = [];

  static const int VIEW_REQUIREMENTS = 0;
  static const int VIEW_SUITES = 1;
  static const int VIEW_SESSIONS = 2;
  static const int VIEW_SETTINGS = 3;

  @override
  void onLoad() {
    projectsController.onChange(Data.currentProject);
    onActiveViewChange(VIEW_REQUIREMENTS);
    notify();

    _subscriptionStackViewEvent = Events.listen<StackViewEvent>(_onViewStacked);
    _subscriptionUnstackViewEvent =
        Events.listen<UnstackViewEvent>(_onViewUnstacked);
  }

  @override
  void onDestroy() {
    _subscriptionStackViewEvent?.cancel();
    _subscriptionUnstackViewEvent?.cancel();
  }

  void onActiveViewChange(int index) {
    activeView = index;
    viewsStack.clear();

    if (index == VIEW_REQUIREMENTS) {
      _addView(RequirementsView.instance());
    } else if (index == VIEW_SUITES) {
      _addView(const SuitesView());
    } else if (index == VIEW_SESSIONS) {
      _addView(const SessionsView());
    } else if (index == VIEW_SETTINGS) {
      _addView(const SettingsView());
    }
  }

  void _addView(Widget view) {
    viewsStack.add(view);
    notify();
  }

  void _removeView() {
    viewsStack.removeLast();
    notify();
  }

  void _onViewStacked(StackViewEvent event) => _addView(event.view);

  void _onViewUnstacked(UnstackViewEvent event) => _removeView();

  void onChangeProject(Project project) {
    Data.onChangeProject(project);
  }

  void onCreateProject(BuildContext context) {
    projectsController.close();

    BaseDialog.show(
      context: context,
      dialog: CreateProjectDialog.instance(
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
