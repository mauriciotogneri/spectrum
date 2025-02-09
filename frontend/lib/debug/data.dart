import 'dart:math';
import 'package:testflow/domain/model/project.dart';
import 'package:testflow/domain/model/requirement.dart';
import 'package:testflow/domain/types/requirement_importance.dart';
import 'package:testflow/domain/types/requirement_status.dart';
import 'package:testflow/domain/types/requirement_type.dart';

class Data {
  static Project currentProject = _projects.first;

  static void onChangeProject(Project project) {
    currentProject = project;
  }

  static void onCreateProject(Project project) {
    _projects.add(project);
    onChangeProject(project);
  }

  static void onCreateRequirement({
    required String name,
    required String description,
    required String id,
    required RequirementType type,
    required RequirementStatus status,
    required RequirementImportance importance,
    required String component,
    required List<String> platforms,
  }) {
    final Requirement requirement = Requirement(
      id: id,
      type: type,
      status: status,
      importance: importance,
      name: name,
      description: description,
      component: component,
      platforms: platforms,
      tags: [],
      numberOfTestCases: 0,
    );
    _requirements.add(requirement);
  }

  static List<Project> projects() {
    _projects.sort((a, b) => a.name.compareTo(b.name));

    return _projects;
  }

  static const List<String> _components = [
    'Authentication',
    'Payments',
    'Chat',
    'Notifications',
    'Analytics',
    'Profile',
    'Security',
  ];

  static const List<String> _platforms = [
    'Web',
    'Android',
    'iOS',
  ];

  static final List<Requirement> _requirements = [
    for (int i = 0; i < 20; i++)
      Requirement(
        id: 'REQ.${i + 1}',
        type: _random(RequirementType.values),
        status: _random(RequirementStatus.values),
        importance: _random(RequirementImportance.values),
        name: 'Requirement ${i + 1}',
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
        component: _random(_components),
        platforms: {
          for (int i = 0; i < Random().nextInt(_platforms.length) + 1; i++)
            _random(_platforms)
        }.toList(),
        tags: [
          for (int i = 0; i < Random().nextInt(3) + 1; i++) 'Tag ${i + 1}'
        ],
        numberOfTestCases: Random().nextInt(20),
      ),
  ];

  static List<Requirement> requirements() => _requirements;

  static T _random<T>(List<T> list) {
    return list[Random().nextInt(list.length)];
  }

  static final List<Project> _projects = [
    const Project(
      id: '1',
      name: 'Project 1',
      description: 'Description 1',
      components: _components,
      platforms: _platforms,
    ),
    const Project(
      id: '2',
      name: 'Project 2',
      description: 'Description 2',
      components: _components,
      platforms: _platforms,
    ),
    const Project(
      id: '3',
      name: 'Project 3',
      description: 'Description 3',
      components: _components,
      platforms: _platforms,
    ),
  ];
}
