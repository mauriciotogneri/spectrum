import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:testflow/debug/data.dart';
import 'package:testflow/domain/model/project.dart';
import 'package:testflow/domain/state/dashboard/dashboard_state.dart';
import 'package:testflow/presentation/common/dropdown/dropdown_input_single.dart';
import 'package:testflow/utils/palette.dart';

class DashboardScreen extends StatelessWidget {
  final DashboardState state;

  const DashboardScreen._(this.state);

  factory DashboardScreen.instance() => DashboardScreen._(DashboardState());

  @override
  Widget build(BuildContext context) {
    return StateProvider<DashboardState>(
      state: state,
      builder: (context, state) => Scaffold(
        body: Content(state),
      ),
    );
  }
}

class Content extends StatelessWidget {
  final DashboardState state;

  const Content(this.state);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        NavigationMenu(state),
        Expanded(
          child: ActiveView(state),
        ),
      ],
    );
  }
}

class NavigationMenu extends StatelessWidget {
  final DashboardState state;

  const NavigationMenu(this.state);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      color: Palette.background2,
      child: SizedBox(
        width: 250,
        child: Column(
          children: [
            const VBox(4),
            ProjectSelector(state),
            const VBox(4),
            NavigationMenuRow(
              state: state,
              text: 'Requirements',
              icon: Icons.checklist,
              index: DashboardState.VIEW_REQUIREMENTS,
            ),
            NavigationMenuRow(
              state: state,
              text: 'Suites',
              icon: Icons.quiz_outlined,
              index: DashboardState.VIEW_SUITES,
            ),
            NavigationMenuRow(
              state: state,
              text: 'Sessions',
              icon: Icons.find_in_page_outlined,
              index: DashboardState.VIEW_SESSIONS,
            ),
            NavigationMenuRow(
              state: state,
              text: 'Settings',
              icon: Icons.settings_outlined,
              index: DashboardState.VIEW_SETTINGS,
            ),
          ],
        ),
      ),
    );
  }
}

class ProjectSelector extends StatelessWidget {
  final DashboardState state;

  const ProjectSelector(this.state);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 4,
          right: 4,
        ),
        child: DropdownInputSingle<Project>(
          values: Data.projects(),
          controller: state.projectsController,
          footer: Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: ShadButton.ghost(
              height: 32,
              icon: const Icon(Icons.add_circle_outline),
              mainAxisAlignment: MainAxisAlignment.start,
              child: const Text('Create project'),
              onPressed: () => state.onCreateProject(context),
            ),
          ),
          onChange: state.onChangeProject,
        ),
      ),
    );
  }
}

class NavigationMenuRow extends StatelessWidget {
  final DashboardState state;
  final String text;
  final IconData icon;
  final int index;

  const NavigationMenuRow({
    required this.state,
    required this.text,
    required this.icon,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = state.activeView == index;

    return Container(
      margin: const EdgeInsets.only(
        top: 4,
        left: 8,
        right: 8,
      ),
      child: ListTile(
        title: Text(
          text,
          style: Theme.of(context).textTheme.labelLarge!.copyWith(
                color: Palette.textEnabled,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
        ),
        leading: Icon(
          icon,
          size: 20,
        ),
        minLeadingWidth: 0,
        dense: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        visualDensity: VisualDensity.compact,
        contentPadding: const EdgeInsets.only(
          top: 0,
          bottom: 0,
          left: 8,
          right: 8,
        ),
        onTap: () => state.onActiveViewChange(index),
        selected: isSelected,
        selectedTileColor: Palette.menuSelected,
        selectedColor: Palette.iconEnabled,
        hoverColor: Palette.menuSelected,
        iconColor: Palette.iconDisabled,
      ),
    );
  }
}

class ActiveView extends StatelessWidget {
  final DashboardState state;

  const ActiveView(this.state);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: state.viewsStack,
    );
  }
}

class SuitesView extends StatelessWidget {
  const SuitesView();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Suites'),
    );
  }
}

class SessionsView extends StatelessWidget {
  const SessionsView();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Sessions'),
    );
  }
}

class SettingsView extends StatelessWidget {
  const SettingsView();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Settings'),
    );
  }
}
