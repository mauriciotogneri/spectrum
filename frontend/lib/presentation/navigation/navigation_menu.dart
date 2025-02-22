import 'package:flutter/material.dart';
import 'package:testflow/debug/data.dart';
import 'package:testflow/domain/model/project.dart';
import 'package:testflow/presentation/common/input/custom_dropdown_single.dart';
import 'package:testflow/presentation/common/input/custom_input.dart';
import 'package:testflow/presentation/common/text/custom_text.dart';
import 'package:testflow/utils/navigation.dart';
import 'package:testflow/utils/palette.dart';
import 'package:testflow/utils/platform.dart';

class NavigationMenu extends StatelessWidget {
  final Widget child;

  const NavigationMenu({required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [const LeftMenu(), Expanded(child: child)],
      ),
    );
  }
}

class LeftMenu extends StatefulWidget {
  const LeftMenu();

  @override
  State<LeftMenu> createState() => _LeftMenuState();
}

class _LeftMenuState extends State<LeftMenu> {
  MenuItem? selectedMenu;

  @override
  void initState() {
    super.initState();

    final String location = Navigation.location(context);

    if (location.endsWith('/dashboard')) {
      selectedMenu = MenuItem.dashboard;
    } else if (location.endsWith('/requirements')) {
      selectedMenu = MenuItem.requirements;
    } else if (location.endsWith('/suites')) {
      selectedMenu = MenuItem.suites;
    } else if (location.endsWith('/sessions')) {
      selectedMenu = MenuItem.sessions;
    } else if (location.endsWith('/settings')) {
      selectedMenu = MenuItem.settings;
    } else if (location.endsWith('/components')) {
      selectedMenu = MenuItem.components;
    }
  }

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
            ProjectSelector(_onProjectSelected),
            NavigationMenuRow(
              text: 'Dashboard',
              icon: Icons.bar_chart,
              isSelected: selectedMenu == MenuItem.dashboard,
              menu: MenuItem.dashboard,
              onSelected: _onMenuSelected,
            ),
            NavigationMenuRow(
              text: 'Requirements',
              icon: Icons.checklist,
              isSelected: selectedMenu == MenuItem.requirements,
              menu: MenuItem.requirements,
              onSelected: _onMenuSelected,
            ),
            NavigationMenuRow(
              text: 'Suites',
              icon: Icons.quiz_outlined,
              isSelected: selectedMenu == MenuItem.suites,
              menu: MenuItem.suites,
              onSelected: _onMenuSelected,
            ),
            NavigationMenuRow(
              text: 'Sessions',
              icon: Icons.find_in_page_outlined,
              isSelected: selectedMenu == MenuItem.sessions,
              menu: MenuItem.sessions,
              onSelected: _onMenuSelected,
            ),
            NavigationMenuRow(
              text: 'Settings',
              icon: Icons.settings_outlined,
              isSelected: selectedMenu == MenuItem.settings,
              menu: MenuItem.settings,
              onSelected: _onMenuSelected,
            ),
            if (Platform.isDebug)
              NavigationMenuRow(
                text: 'Components',
                icon: Icons.format_paint_outlined,
                isSelected: selectedMenu == MenuItem.components,
                menu: MenuItem.components,
                onSelected: _onMenuSelected,
              ),
          ],
        ),
      ),
    );
  }

  void _onProjectSelected(BuildContext context, Project project) {
    Data.onChangeProject(project);
    setState(() => selectedMenu = MenuItem.dashboard);
    Navigation.dashboard(context: context, projectId: project.id);
  }

  void _onMenuSelected(MenuItem menu) {
    setState(() => selectedMenu = menu);
    final String projectId = Data.currentProject.id;

    switch (menu) {
      case MenuItem.dashboard:
        Navigation.dashboard(context: context, projectId: projectId);
        break;
      case MenuItem.requirements:
        Navigation.requirements(context: context, projectId: projectId);
        break;
      case MenuItem.suites:
        Navigation.suites(context: context, projectId: projectId);
        break;
      case MenuItem.sessions:
        Navigation.sessions(context: context, projectId: projectId);
        break;
      case MenuItem.settings:
        Navigation.settings(context: context, projectId: projectId);
        break;
      case MenuItem.components:
        Navigation.components(context: context, projectId: projectId);
        break;
    }
  }
}

class ProjectSelector extends StatefulWidget {
  final Function(BuildContext, Project) onSelected;

  const ProjectSelector(this.onSelected);

  @override
  State<ProjectSelector> createState() => _ProjectSelectorState();
}

class _ProjectSelectorState extends State<ProjectSelector> {
  final CustomDropdownSingleController<Project> controller =
      CustomDropdownSingleController();

  @override
  void initState() {
    super.initState();
    controller.select(Data.currentProject);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
        child: CustomDropdownSingle<Project>(
          values: DropdownItem.fromList(Data.projects()),
          hint: 'Project',
          controller: controller,
          onSelected: (project) => widget.onSelected(context, project),
        ),
      ),
    );
  }
}

class NavigationMenuRow extends StatelessWidget {
  final String text;
  final IconData icon;
  final bool isSelected;
  final MenuItem menu;
  final Function(MenuItem) onSelected;

  const NavigationMenuRow({
    required this.text,
    required this.icon,
    required this.isSelected,
    required this.menu,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
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
        onTap: () => onSelected(menu),
        selected: isSelected,
        tileColor: Palette.transparent,
        selectedTileColor: Palette.menuSelectedLight,
      ),
    );
  }
}

enum MenuItem {
  dashboard,
  requirements,
  suites,
  sessions,
  settings,
  components,
}
