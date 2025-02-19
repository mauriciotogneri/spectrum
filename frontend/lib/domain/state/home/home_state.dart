import 'dart:async';

import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:testflow/debug/data.dart';
import 'package:testflow/domain/events/events.dart';
import 'package:testflow/domain/events/stack_view_event.dart';
import 'package:testflow/domain/events/unstack_view_event.dart';
import 'package:testflow/domain/model/project.dart';
import 'package:testflow/presentation/common/input/custom_dropdown_single.dart';
import 'package:testflow/presentation/components/components_view.dart';
import 'package:testflow/presentation/dashboard/dashboard_view.dart';
import 'package:testflow/presentation/dialogs/base_dialog.dart';
import 'package:testflow/presentation/dialogs/create_project_dialog.dart';
import 'package:testflow/presentation/home/home_screen.dart';
import 'package:testflow/presentation/requirements/requirements_list_view.dart';

class HomeState extends BaseState {
  HomeView activeView = HomeView.requirements;
  StreamSubscription? _subscriptionStackViewEvent;
  StreamSubscription? _subscriptionUnstackViewEvent;
  final CustomDropdownSingleController<Project> projectsController =
      CustomDropdownSingleController();
  final List<Widget> viewsStack = [];

  @override
  void onLoad() {
    projectsController.select(Data.currentProject);
    onRootViewChange(activeView);
    notify();

    _subscriptionStackViewEvent = Events.listen<StackViewEvent>(_onViewStacked);
    _subscriptionUnstackViewEvent = Events.listen<UnstackViewEvent>(
      _onViewUnstacked,
    );
  }

  @override
  void onDestroy() {
    _subscriptionStackViewEvent?.cancel();
    _subscriptionUnstackViewEvent?.cancel();
  }

  List<DropdownItem<Project>> get projects =>
      DropdownItem.fromList(Data.projects());

  void onRootViewChange(HomeView view) {
    activeView = view;
    viewsStack.clear();

    if (view == HomeView.dashboard) {
      _addView(DashboardView.instance());
    } else if (view == HomeView.requirements) {
      _addView(RequirementsListView.instance());
    } else if (view == HomeView.suites) {
      _addView(const SuitesView());
    } else if (view == HomeView.sessions) {
      _addView(const SessionsView());
    } else if (view == HomeView.settings) {
      _addView(const SettingsView());
    } else if (view == HomeView.components) {
      _addView(ComponentsView.instance());
    }
  }

  void _addView(Widget view) {
    viewsStack.add(view);
    notify();
  }

  void _onViewStacked(StackViewEvent event) => _addView(event.view);

  void _onViewUnstacked(UnstackViewEvent event) {
    for (int i = 0; i < event.amount; i++) {
      viewsStack.removeLast();
    }

    notify();
  }

  void onChangeProject(Project project) {
    Data.onChangeProject(project);
    onRootViewChange(activeView);
  }

  void onCreateProject(BuildContext context) => BaseDialog.show(
    context: context,
    dialog: CreateProjectDialog.instance(onCreateProject: _createProject),
  );

  void _createProject({required String name, required String description}) {
    Data.onCreateProject(
      Project(
        id: '',
        name: name,
        description: description,
        components: [],
        platforms: [],
      ),
    );
    notify();
  }
}

enum HomeView {
  dashboard,
  requirements,
  suites,
  sessions,
  settings,
  components,
}
