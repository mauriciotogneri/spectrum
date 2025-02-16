import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:testflow/domain/model/project.dart';
import 'package:testflow/domain/state/dashboard/dashboard_state.dart';
import 'package:testflow/presentation/common/input/custom_dropdown_single.dart';
import 'package:testflow/presentation/common/input/custom_input.dart';
import 'package:testflow/presentation/common/text/custom_text.dart';
import 'package:testflow/utils/palette.dart';

class DashboardScreen extends StatelessWidget {
  final DashboardState state;

  const DashboardScreen._(this.state);

  factory DashboardScreen.instance() => DashboardScreen._(DashboardState());

  @override
  Widget build(BuildContext context) {
    return StateProvider<DashboardState>(
      state: state,
      builder: (context, state) => Scaffold(body: Content(state)),
    );
  }
}

class Content extends StatelessWidget {
  final DashboardState state;

  const Content(this.state);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [NavigationMenu(state), Expanded(child: ActiveView(state))],
    );
  }
}

class NavigationMenu extends StatelessWidget {
  final DashboardState state;

  const NavigationMenu(this.state);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 0,
      color: Palette.backgroundEmpty,
      child: SizedBox(
        width: 250,
        child: Column(
          children: [
            ProjectSelector(state),
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
        padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
        child: CustomDropdownSingle<Project>(
          values: state.projects,
          hint: 'Project',
          controller: state.projectsController,
          /*footer: Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: TextButton(
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.add_circle_outline),
                  Text('Create project'),
                ],
              ),
              onPressed: () => state.onCreateProject(context),
            ),
          ),*/
          onSelected: state.onChangeProject,
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
      margin: const EdgeInsets.only(top: 8, left: 16, right: 16),
      child: ListTile(
        title: CustomText(
          text: text,
          size: 14,
          color: isSelected ? Palette.menuSelectedDark : Palette.textBody,
          weight: FontWeight.w600,
        ),
        leading: Icon(icon, size: 18),
        selectedColor: Palette.menuSelectedDark,
        iconColor: Palette.iconEnabled,
        minLeadingWidth: 0,
        dense: true,
        shape: RoundedRectangleBorder(borderRadius: CustomInput.borderRadius),
        visualDensity: VisualDensity.compact,
        contentPadding: const EdgeInsets.only(
          top: 0,
          bottom: 0,
          left: 12,
          right: 8,
        ),
        onTap: () => state.onRootViewChange(index),
        selected: isSelected,
        tileColor: Palette.transparent,
        selectedTileColor: Palette.menuSelectedLight,
      ),
    );
  }
}

class ActiveView extends StatelessWidget {
  final DashboardState state;

  const ActiveView(this.state);

  @override
  Widget build(BuildContext context) {
    return Stack(children: state.viewsStack);
  }
}

class SuitesView extends StatelessWidget {
  const SuitesView();

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Suites'));
  }
}

class SessionsView extends StatelessWidget {
  const SessionsView();

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Sessions'));
  }
}

class SettingsView extends StatelessWidget {
  const SettingsView();

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Settings'));
  }
}
