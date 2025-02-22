import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:testflow/domain/model/requirement.dart';
import 'package:testflow/domain/types/test_case_execution.dart';
import 'package:testflow/extensions/string_extension.dart';
import 'package:testflow/presentation/common/table/custom_table.dart';
import 'package:testflow/presentation/common/text/body_medium.dart';
import 'package:testflow/utils/formatter.dart';

class TestCase implements TableElement {
  final String id;
  final Requirement requirement;
  final String name;
  final TestCaseExecution execution;
  final String preconditions;
  final String steps;
  final String expected;
  final DateTime lastRun;
  final List<String> tags;
  final DateTime createdOn;
  final String createdBy;
  final DateTime updatedOn;
  final String updatedBy;

  const TestCase({
    required this.id,
    required this.requirement,
    required this.name,
    required this.execution,
    required this.preconditions,
    required this.steps,
    required this.expected,
    required this.lastRun,
    required this.tags,
    required this.createdOn,
    required this.createdBy,
    required this.updatedOn,
    required this.updatedBy,
  });

  bool matches({
    required String queryFilter,
    required List<TestCaseExecution> executionFilter,
  }) {
    if (queryFilter.isEmpty && executionFilter.isEmpty) {
      return true;
    } else {
      final bool matchesQuery =
          queryFilter.isEmpty ||
          name.matches(queryFilter) ||
          preconditions.matches(queryFilter) ||
          steps.matches(queryFilter) ||
          expected.matches(queryFilter) ||
          tags.any((tag) => tag.matches(queryFilter));
      final bool matchesExecution =
          executionFilter.isEmpty || executionFilter.contains(execution);

      return matchesQuery && matchesExecution;
    }
  }

  static List<TableColumn> get columns => const [
    TableColumn(id: TestCaseColumn.name, name: 'Name'),
    TableColumn(
      id: TestCaseColumn.executionType,
      name: 'Execution',
      width: 200,
      alignment: Alignment.center,
    ),
    TableColumn(id: TestCaseColumn.lastRun, name: 'Last run', width: 300),
  ];

  @override
  Widget cell(TableColumn column) {
    switch (column.id) {
      case TestCaseColumn.name:
        return BodyMedium(text: name);
      case TestCaseColumn.executionType:
        return execution.chip;
      case TestCaseColumn.lastRun:
        return Tooltip(
          message: Formatter.fullDateTime(lastRun),
          child: BodyMedium(text: '${Formatter.daysAgo(lastRun)} days ago'),
        );
      default:
        return const Empty();
    }
  }
}

enum TestCaseColumn { name, executionType, lastRun }
