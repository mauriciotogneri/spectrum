import 'dart:math';
import 'package:testflow/domain/model/project.dart';
import 'package:testflow/domain/model/requirement.dart';
import 'package:testflow/domain/model/test_case.dart';
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

  static const List<String> _platforms = ['Web', 'Android', 'iOS'];

  static final List<Requirement> _requirements = [
    for (int i = 0; i < 20; i++)
      Requirement(
        id: 'REQ.${i + 1}',
        type: _random(RequirementType.values),
        status: _random(RequirementStatus.values),
        importance: _random(RequirementImportance.values),
        name: 'Requirement ${i + 1}',
        description: _random(_texts),
        component: _random(_components),
        platforms:
            {
              for (int i = 0; i < Random().nextInt(_platforms.length) + 1; i++)
                _random(_platforms),
            }.toList(),
        tags: [
          for (int i = 0; i < Random().nextInt(3) + 1; i++) 'Tag ${i + 1}',
        ],
      ),
  ];

  static final List<TestCase> _testCases = [
    for (final Requirement requirement in _requirements)
      for (int i = 0; i < Random().nextInt(50) + 1; i++)
        TestCase(
          requirement: requirement,
          name: 'Test case ${i + 1}',
          isAutomated: Random().nextBool(),
          preconditions: _random(_texts),
          steps: _random(_texts),
          expected: _random(_texts),
          lastRun: DateTime.now().subtract(
            Duration(days: Random().nextInt(30)),
          ),
        ),
  ];

  static List<Requirement> requirements() => _requirements;

  static List<TestCase> testCases(Requirement requirement) =>
      _testCases
          .where((testCase) => testCase.requirement == requirement)
          .toList();

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

  static final List<String> _texts = [
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
    'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
    'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.',
    'Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
    'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.',
    'Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt.',
    'Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem.',
    'Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?',
  ];
}
