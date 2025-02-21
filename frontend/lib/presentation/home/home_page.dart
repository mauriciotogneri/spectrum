import 'package:dafluta/dafluta.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:testflow/domain/model/project.dart';
import 'package:testflow/domain/state/home/home_state.dart';
import 'package:testflow/presentation/common/input/custom_dropdown_single.dart';
import 'package:testflow/presentation/common/input/custom_input.dart';
import 'package:testflow/presentation/common/text/custom_text.dart';
import 'package:testflow/utils/palette.dart';

class HomePage extends StatelessWidget {
  final HomeState state;

  const HomePage._(this.state);

  factory HomePage.instance() => HomePage._(HomeState());

  @override
  Widget build(BuildContext context) {
    return StateProvider<HomeState>(
      state: state,
      builder: (context, state) => Scaffold(body: Content(state)),
    );
  }
}

class Content extends StatelessWidget {
  final HomeState state;

  const Content(this.state);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [NavigationMenu(state), Expanded(child: ActiveView(state))],
    );
  }
}

class NavigationMenu extends StatelessWidget {
  final HomeState state;

  const NavigationMenu(this.state);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 0,
      color: Palette.backgroundEmpty,
      child: SizedBox(
        width: 250,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            ProjectSelector(state),
            NavigationMenuRow(
              state: state,
              text: 'Dashboard',
              icon: Icons.bar_chart,
              view: HomeView.dashboard,
            ),
            NavigationMenuRow(
              state: state,
              text: 'Requirements',
              icon: Icons.checklist,
              view: HomeView.requirements,
            ),
            NavigationMenuRow(
              state: state,
              text: 'Suites',
              icon: Icons.quiz_outlined,
              view: HomeView.suites,
            ),
            NavigationMenuRow(
              state: state,
              text: 'Sessions',
              icon: Icons.find_in_page_outlined,
              view: HomeView.sessions,
            ),
            NavigationMenuRow(
              state: state,
              text: 'Settings',
              icon: Icons.settings_outlined,
              view: HomeView.settings,
            ),
            if (kDebugMode)
              NavigationMenuRow(
                state: state,
                text: 'Components',
                icon: Icons.format_paint_outlined,
                view: HomeView.components,
              ),
          ],
        ),
      ),
    );
  }
}

class ProjectSelector extends StatelessWidget {
  final HomeState state;

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
          onSelected: state.onChangeProject,
        ),
      ),
    );
  }
}

class NavigationMenuRow extends StatelessWidget {
  final HomeState state;
  final String text;
  final IconData icon;
  final HomeView view;

  const NavigationMenuRow({
    required this.state,
    required this.text,
    required this.icon,
    required this.view,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = state.activeView == view;

    return Container(
      margin: const EdgeInsets.only(top: 8, left: 16, right: 16),
      child: ListTile(
        title: CustomText(
          text: text,
          size: 14,
          color: isSelected ? Palette.menuSelectedDark : Palette.textBody,
          weight: FontWeight.w500,
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
        onTap: () => state.onRootViewChange(view),
        selected: isSelected,
        tileColor: Palette.transparent,
        selectedTileColor: Palette.menuSelectedLight,
      ),
    );
  }
}

class ActiveView extends StatelessWidget {
  final HomeState state;

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
