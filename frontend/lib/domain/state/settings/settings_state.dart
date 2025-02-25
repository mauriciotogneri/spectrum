import 'package:dafluta/dafluta.dart';
import 'package:testflow/debug/data.dart';

class SettingsState extends BaseState {
  final String projectId;

  static const String environment = 'environment';
  static const String platform = 'platform';
  static const String components = 'components';
  static const String devices = 'devices';

  SettingsState({required this.projectId});

  void onAdd({required String name, required String value}) {
    switch (name) {
      case environment:
        Data.currentProject.environments.add(value);
        break;
      case platform:
        Data.currentProject.platforms.add(value);
        break;
      case components:
        Data.currentProject.components.add(value);
        break;
      case devices:
        Data.currentProject.devices.add(value);
        break;
    }
  }

  void onRemove({required String name, required String value}) {
    switch (name) {
      case environment:
        Data.currentProject.environments.remove(value);
        break;
      case platform:
        Data.currentProject.platforms.remove(value);
        break;
      case components:
        Data.currentProject.components.remove(value);
        break;
      case devices:
        Data.currentProject.devices.remove(value);
        break;
    }
  }
}
