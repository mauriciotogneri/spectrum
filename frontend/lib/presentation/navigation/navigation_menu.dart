import 'package:flutter/material.dart';
import 'package:testflow/debug/data.dart';
import 'package:testflow/domain/model/project.dart';
import 'package:testflow/extensions/build_context_extension.dart';
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
        children: [
          const LeftMenu(),
          const VerticalDivider(width: 0.5, color: Palette.borderInputEnabled),
          Expanded(child: child),
        ],
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
              onSelected:
                  (menu) => _onMenuSelected(context: context, menu: menu),
            ),
            NavigationMenuRow(
              text: 'Requirements',
              icon: Icons.description_outlined,
              isSelected: selectedMenu == MenuItem.requirements,
              menu: MenuItem.requirements,
              onSelected:
                  (menu) => _onMenuSelected(context: context, menu: menu),
            ),
            NavigationMenuRow(
              text: 'Suites',
              icon: Icons.event_repeat_outlined,
              isSelected: selectedMenu == MenuItem.suites,
              menu: MenuItem.suites,
              onSelected:
                  (menu) => _onMenuSelected(context: context, menu: menu),
            ),
            NavigationMenuRow(
              text: 'Sessions',
              icon: Icons.checklist,
              isSelected: selectedMenu == MenuItem.sessions,
              menu: MenuItem.sessions,
              onSelected:
                  (menu) => _onMenuSelected(context: context, menu: menu),
            ),
            NavigationMenuRow(
              text: 'Settings',
              icon: Icons.tune,
              isSelected: selectedMenu == MenuItem.settings,
              menu: MenuItem.settings,
              onSelected:
                  (menu) => _onMenuSelected(context: context, menu: menu),
            ),
            if (Platform.isDebug)
              NavigationMenuRow(
                text: 'Components',
                icon: Icons.format_paint_outlined,
                isSelected: selectedMenu == MenuItem.components,
                menu: MenuItem.components,
                onSelected:
                    (menu) => _onMenuSelected(context: context, menu: menu),
              ),
          ],
        ),
      ),
    );
  }

  void _onProjectSelected(BuildContext context, Project project) {
    Data.changeProject(project);
    setState(() => selectedMenu = MenuItem.dashboard);
    context.dashboard(projectId: project.id);
  }

  void _onMenuSelected({
    required BuildContext context,
    required MenuItem menu,
  }) {
    setState(() => selectedMenu = menu);
    final String projectId = Data.currentProject.id;

    switch (menu) {
      case MenuItem.dashboard:
        context.dashboard(projectId: projectId);
        break;
      case MenuItem.requirements:
        context.requirementList(projectId: projectId);
        break;
      case MenuItem.suites:
        context.suiteList(projectId: projectId);
        break;
      case MenuItem.sessions:
        context.sessionList(projectId: projectId);
        break;
      case MenuItem.settings:
        context.settings(projectId: projectId);
        break;
      case MenuItem.components:
        context.components(projectId: projectId);
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
        shape: RoundedRectangleBorder(
          borderRadius: CustomInput.borderRadius,
          side:
              isSelected
                  ? const BorderSide(
                    color: Palette.borderInputEnabled,
                    width: 0.5,
                  )
                  : BorderSide.none,
        ),
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
