import 'dart:math';
import 'package:testflow/domain/model/attachment.dart';
import 'package:testflow/domain/model/project.dart';
import 'package:testflow/domain/model/requirement.dart';
import 'package:testflow/domain/model/test_case.dart';
import 'package:testflow/domain/model/test_run.dart';
import 'package:testflow/domain/model/test_session.dart';
import 'package:testflow/domain/model/test_suite.dart';
import 'package:testflow/domain/types/attachment_type.dart';
import 'package:testflow/domain/types/requirement_importance.dart';
import 'package:testflow/domain/types/requirement_status.dart';
import 'package:testflow/domain/types/requirement_type.dart';
import 'package:testflow/domain/types/test_case_execution.dart';
import 'package:testflow/domain/types/test_run_reproducibility.dart';
import 'package:testflow/domain/types/test_run_result.dart';
import 'package:testflow/domain/types/test_session_status.dart';

class Data {
  static Project currentProject = _projects.first;

  static void changeProject(Project project) {
    currentProject = project;
  }

  static void createProject(Project project) {
    _projects.add(project);
    changeProject(project);
  }

  static void createRequirement({
    required String name,
    required String description,
    required String code,
    required RequirementType type,
    required RequirementStatus status,
    required RequirementImportance importance,
    required String component,
    required List<String> platforms,
  }) {
    final Requirement requirement = Requirement(
      id: DateTime.now().toIso8601String(),
      code: code,
      type: type,
      status: status,
      importance: importance,
      name: name,
      description: description,
      component: component,
      platforms: platforms,
      tags: [],
      createdOn: randomDate(),
      createdBy: 'John Doe',
      updatedOn: randomDate(),
      updatedBy: 'Jane Doe',
    );
    _requirements.add(requirement);
  }

  static void createTestCase({
    required Requirement requirement,
    required String name,
    required TestCaseExecution execution,
    required String preconditions,
    required String steps,
    required String expected,
  }) {
    final TestCase testCase = TestCase(
      id: DateTime.now().toIso8601String(),
      requirementId: requirement.id,
      name: name,
      execution: execution,
      preconditions: preconditions,
      steps: steps,
      expected: expected,
      lastRun: Random().nextInt(10) > 2 ? randomDate() : null,
      lastResults: _randomList(TestRunResult.values),
      tags: [],
      createdOn: randomDate(),
      createdBy: 'John Doe',
      updatedOn: randomDate(),
      updatedBy: 'Jane Doe',
    );
    _testCases.add(testCase);
  }

  static void createTestSuite({
    required String name,
    required List<RequirementType> types,
    required List<RequirementImportance> importances,
    required List<String> components,
    required List<String> platforms,
  }) {
    final TestSuite testSuite = TestSuite(
      id: DateTime.now().toIso8601String(),
      name: name,
      types: types,
      importances: importances,
      components: components,
      platforms: platforms,
      tags: [],
      createdOn: randomDate(),
      createdBy: 'John Doe',
      updatedOn: randomDate(),
      updatedBy: 'Jane Doe',
    );
    _testSuites.add(testSuite);
  }

  static void deleteRequirement(Requirement requirement) {
    _requirements.remove(requirement);
  }

  static void deleteTestCase(TestCase testCase) {
    _testCases.remove(testCase);
  }

  static void deleteTestSuite(TestSuite testSuite) {
    _testSuites.remove(testSuite);
  }

  static void deleteTestSession(TestSession testSession) {
    _testSessions.remove(testSession);
  }

  static void deleteAttachment(Attachment attachment) {
    _attachments.remove(attachment);
  }

  static List<Project> projects() {
    _projects.sort((a, b) => a.name.compareTo(b.name));

    return _projects;
  }

  static Project projectById(String id) {
    for (final Project project in _projects) {
      if (project.id == id) {
        return project;
      }
    }

    throw Exception('Project not found');
  }

  static Requirement requirementById(String id) {
    for (final Requirement requirement in _requirements) {
      if (requirement.id == id) {
        return requirement;
      }
    }

    throw Exception('Requirement not found');
  }

  static TestCase testCaseById(String id) {
    for (final TestCase testCase in _testCases) {
      if (testCase.id == id) {
        return testCase;
      }
    }

    throw Exception('Test case not found');
  }

  static TestSuite testSuiteById(String id) {
    for (final TestSuite testSuite in _testSuites) {
      if (testSuite.id == id) {
        return testSuite;
      }
    }

    throw Exception('Test suite not found');
  }

  static TestSession testSessionById(String id) {
    for (final TestSession testSession in _testSessions) {
      if (testSession.id == id) {
        return testSession;
      }
    }

    throw Exception('Test suite not found');
  }

  // ignore: prefer_final_fields
  static List<String> _environments = [
    'Development',
    'Integration',
    'Staging',
    'Production',
  ];

  // ignore: prefer_final_fields
  static List<String> _platforms = ['Web', 'Android', 'iOS'];

  // ignore: prefer_final_fields
  static List<String> _components = [
    'Authentication',
    'Payments',
    'Chat',
    'Notifications',
    'Analytics',
    'Profile',
    'Security',
  ];

  // ignore: prefer_final_fields
  static List<String> _devices = [
    'Google Pixel',
    'Samsung Galaxy',
    'iPhone 12',
    'Chrome',
    'Firefox',
    'Safari',
    'Edge',
    'Opera',
  ];

  static final List<Requirement> _requirements = [
    for (int i = 0; i < 20; i++)
      Requirement(
        id: '${i + 1}',
        type: _random(RequirementType.values),
        status: _random(RequirementStatus.values),
        importance: _random(RequirementImportance.values),
        code: 'REQ.${i + 1}',
        name: 'Requirement ${i + 1}',
        description: _random(_texts),
        component: _random(_components),
        platforms: _randomList(_platforms),
        tags: [
          for (int i = 0; i < Random().nextInt(3) + 1; i++) 'Tag ${i + 1}',
        ],
        createdOn: randomDate(),
        createdBy: 'John Doe',
        updatedOn: randomDate(),
        updatedBy: 'Jane Doe',
      ),
  ];

  static final List<TestCase> _testCases = [
    for (final Requirement requirement in _requirements)
      for (int i = 0; i < Random().nextInt(50) + 1; i++)
        TestCase(
          id: '${requirement.id}-${i + 1}',
          requirementId: requirement.id,
          name: 'Test case ${i + 1}',
          execution: _random(TestCaseExecution.values),
          preconditions: _random(_texts),
          steps: _random(_texts),
          expected: _random(_texts),
          lastRun: Random().nextInt(10) > 2 ? randomDate() : null,
          lastResults: _randomRepeatedList(TestRunResult.values, 5),
          tags: [
            for (int i = 0; i < Random().nextInt(3) + 1; i++) 'Tag ${i + 1}',
          ],
          createdOn: randomDate(),
          createdBy: 'John Doe',
          updatedOn: randomDate(),
          updatedBy: 'Jane Doe',
        ),
  ];

  static final List<TestRun> _testRuns = [
    for (final TestCase testCase in _testCases)
      for (int i = 0; i < Random().nextInt(10) + 1; i++)
        TestRun(
          id: '${testCase.requirementId}-${testCase.id}-${i + 1}',
          requirementId: testCase.requirementId,
          testCaseId: testCase.id,
          name: 'Test run ${i + 1}',
          preconditions: testCase.preconditions,
          steps: testCase.steps,
          expected: testCase.expected,
          actual: _random(_texts),
          result: _random(TestRunResult.values),
          reproducibility: _random(TestRunReproducibility.values),
          timestamp: randomDate(),
          createdOn: randomDate(),
          createdBy: 'John Doe',
          updatedOn: randomDate(),
          updatedBy: 'Jane Doe',
        ),
  ];

  static final List<TestSuite> _testSuites = [
    for (int i = 0; i < 10; i++)
      TestSuite(
        id: '${i + 1}',
        name: 'Test suite ${i + 1}',
        types: _randomList(RequirementType.values),
        importances: _randomList(RequirementImportance.values),
        components: _randomList(_components),
        platforms: _randomList(_platforms),
        tags: [
          for (int i = 0; i < Random().nextInt(3) + 1; i++) 'Tag ${i + 1}',
        ],
        createdOn: randomDate(),
        createdBy: 'John Doe',
        updatedOn: randomDate(),
        updatedBy: 'Jane Doe',
      ),
  ];

  static final List<TestSession> _testSessions = [
    for (int i = 0; i < _testSuites.length; i++)
      for (int j = 0; j < Random().nextInt(3) + 1; j++)
        TestSession(
          id: '${((i + 1) * 10) + (j + 1)}',
          testSuiteId: _testSuites[i].id,
          name: 'Test session ${((i + 1) * 10) + (j + 1)}',
          startedOn: randomDate(),
          endedOn: null,
          timeSpent: 123,
          status: _random(TestSessionStatus.values),
          environment: _random(_environments),
          platform: _random(_platforms),
          device: _random(_devices),
          version:
              '${Random().nextInt(10)}.${Random().nextInt(10)}.${Random().nextInt(10)}',
          createdOn: randomDate(),
          createdBy: 'John Doe',
          updatedOn: randomDate(),
          updatedBy: 'Jane Doe',
        ),
  ];

  static final List<Attachment> _attachments = [
    for (int i = 0; i < 10; i++)
      Attachment(
        path: '',
        name: 'Attachment ${i + 1}',
        url: 'https://place.dog/500/500',
        type: _random(AttachmentType.values),
        size: _randomFileSize(),
        uploadedOn: randomDate(),
        uploadedBy: 'John Doe',
      ),
  ];

  static List<Requirement> requirements() => _requirements;

  static List<TestSuite> testSuites() => _testSuites;

  static List<TestCase> testCases(Requirement requirement) =>
      _testCases
          .where((testCase) => testCase.requirementId == requirement.id)
          .toList();

  static List<TestRun> testRuns(TestCase testCase) =>
      _testRuns.where((testRun) => testRun.testCaseId == testCase.id).toList();

  static List<TestSession> testSessions() => _testSessions;

  static List<TestSession> testSessionsByTestSuite(TestSuite testSuite) =>
      _testSessions
          .where((testSession) => testSession.testSuiteId == testSuite.id)
          .toList();

  static List<Attachment> attachments() => _attachments;

  static int _randomFileSize() {
    final int group = Random().nextInt(3);

    if (group == 0) {
      return Random().nextInt(1024);
    } else if (group == 1) {
      return Random().nextInt(1024 * 10);
    } else {
      return Random().nextInt(1024 * 1024 * 10);
    }
  }

  static T _random<T>(List<T> list) => list[Random().nextInt(list.length)];

  static List<T> _randomList<T>(List<T> list) {
    final Set<T> result = {};

    for (int i = 0; i < Random().nextInt(list.length) + 1; i++) {
      result.add(_random(list));
    }

    return result.toList();
  }

  static List<T> _randomRepeatedList<T>(List<T> list, int limit) {
    final List<T> result = [];

    for (int i = 0; i < Random().nextInt(limit); i++) {
      result.add(_random(list));
    }

    return result;
  }

  static DateTime randomDate() =>
      DateTime.now().subtract(Duration(days: Random().nextInt(30)));

  static final List<Project> _projects = [
    Project(
      id: '1',
      name: 'Project 1',
      description: 'Description 1',
      components: _components,
      platforms: _platforms,
      environments: _environments,
      devices: _devices,
    ),
    Project(
      id: '2',
      name: 'Project 2',
      description: 'Description 2',
      components: _components,
      platforms: _platforms,
      environments: _environments,
      devices: _devices,
    ),
    Project(
      id: '3',
      name: 'Project 3',
      description: 'Description 3',
      components: _components,
      platforms: _platforms,
      environments: _environments,
      devices: _devices,
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
