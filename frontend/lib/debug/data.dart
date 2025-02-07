import 'package:testflow/domain/model/project.dart';

class Data {
  static Project currentProject = projects.first;

  static void onChangeProject(Project project) {
    currentProject = project;
  }

  static List<Project> projects = [
    Project(
      id: '1',
      name: 'Project 1',
    ),
    Project(
      id: '2',
      name: 'Project 2',
    ),
    Project(
      id: '3',
      name: 'Project 3',
    ),
  ];
}
