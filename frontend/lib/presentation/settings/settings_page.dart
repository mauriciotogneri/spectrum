import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:testflow/debug/data.dart';
import 'package:testflow/domain/state/settings/settings_state.dart';
import 'package:testflow/presentation/common/card/custom_card.dart';
import 'package:testflow/presentation/common/input/custom_text_input.dart';
import 'package:testflow/presentation/common/layout/pane.dart';
import 'package:testflow/presentation/common/navigation/navigation_path.dart';
import 'package:testflow/presentation/common/text/custom_text.dart';
import 'package:testflow/utils/navigation.dart';
import 'package:testflow/utils/palette.dart';

class SettingsPage extends StatelessWidget {
  final SettingsState state;

  const SettingsPage._(this.state);

  factory SettingsPage.instance({required String projectId}) =>
      SettingsPage._(SettingsState(projectId: projectId));

  @override
  Widget build(BuildContext context) {
    return StateProvider<SettingsState>(
      state: state,
      builder: (context, state) => Content(state),
    );
  }
}

class Content extends StatelessWidget {
  final SettingsState state;

  const Content(this.state);

  @override
  Widget build(BuildContext context) {
    return Pane.scrollable(children: [Header(state), Body(state)]);
  }
}

class Header extends StatelessWidget {
  final SettingsState state;

  const Header(this.state);

  @override
  Widget build(BuildContext context) {
    return PaneHeader(
      path: NavigationPath(
        paths: [
          PathItem(
            text: 'Settings',
            path: Navigation.settingsPath(projectId: state.projectId),
          ),
        ],
      ),
    );
  }
}

class Body extends StatelessWidget {
  final SettingsState state;

  const Body(this.state);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 32, left: 32, right: 32),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomList(
            name: 'Environment',
            initialValues: Data.currentProject.environments,
            onAdd: (value) => Data.currentProject.environments.add(value),
            onRemove: (value) => Data.currentProject.environments.remove(value),
          ),
          const HBox(32),
          CustomList(
            name: 'Platforms',
            initialValues: Data.currentProject.platforms,
            onAdd: (value) => Data.currentProject.platforms.add(value),
            onRemove: (value) => Data.currentProject.platforms.remove(value),
          ),
          const HBox(32),
          CustomList(
            name: 'Components',
            initialValues: Data.currentProject.components,
            onAdd: (value) => Data.currentProject.components.add(value),
            onRemove: (value) => Data.currentProject.components.remove(value),
          ),
          const HBox(32),
          CustomList(
            name: 'Devices',
            initialValues: Data.currentProject.devices,
            onAdd: (value) => Data.currentProject.devices.add(value),
            onRemove: (value) => Data.currentProject.devices.remove(value),
          ),
        ],
      ),
    );
  }
}

class CustomList extends StatefulWidget {
  final String name;
  final List<String> initialValues;
  final Function(String) onAdd;
  final Function(String) onRemove;

  const CustomList({
    required this.name,
    required this.initialValues,
    required this.onAdd,
    required this.onRemove,
  });

  @override
  State<CustomList> createState() =>
      _CustomListState(values: [...initialValues]);
}

class _CustomListState extends State<CustomList> {
  final CustomTextInputController controller = CustomTextInputController();
  final List<String> values;

  _CustomListState({required this.values}) {
    values.sort();
  }

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      width: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomTextInput(
            name: widget.name,
            controller: controller,
            onSubmitted: _onAdd,
          ),
          const VBox(16),
          for (final String value in values)
            CustomListEntry(value: value, onRemove: _onRemove),
        ],
      ),
    );
  }

  void _onRemove(String value) {
    setState(() {
      widget.onRemove(value);
      values.remove(value);
    });
  }

  void _onAdd(String value) {
    setState(() {
      controller.clear();
      controller.focus();

      if (!values.contains(value)) {
        widget.onAdd(value);
        values.add(value);
        values.sort();
      }
    });
  }
}

class CustomListEntry extends StatelessWidget {
  final String value;
  final Function(String) onRemove;

  const CustomListEntry({required this.value, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: CustomText(text: value, size: 14, weight: FontWeight.normal),
      trailing: IconButton(
        icon: const Icon(Icons.delete, size: 18, color: Palette.semanticError),
        onPressed: () => onRemove(value),
      ),
      shape: const RoundedRectangleBorder(
        side: BorderSide(color: Palette.borderInputEnabled, width: 0.5),
      ),
      dense: true,
      visualDensity: VisualDensity.compact,
      contentPadding: const EdgeInsets.only(
        top: 0,
        bottom: 0,
        left: 12,
        right: 0,
      ),
    );
  }
}
