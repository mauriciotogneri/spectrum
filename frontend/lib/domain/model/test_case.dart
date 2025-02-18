import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:testflow/domain/model/requirement.dart';
import 'package:testflow/domain/types/test_case_execution.dart';
import 'package:testflow/presentation/common/table/custom_table.dart';
import 'package:testflow/presentation/common/text/body_medium.dart';
import 'package:testflow/presentation/common/text/body_small.dart';
import 'package:testflow/utils/formatter.dart';
import 'package:testflow/utils/palette.dart';

class TestCase implements TableElement {
  final Requirement requirement;
  final String name;
  final TestCaseExecution execution;
  final String preconditions;
  final String steps;
  final String expected;
  final DateTime lastRun;

  const TestCase({
    required this.requirement,
    required this.name,
    required this.execution,
    required this.preconditions,
    required this.steps,
    required this.expected,
    required this.lastRun,
  });

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
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            BodyMedium(text: Formatter.fullDateTime(lastRun)),
            BodySmall(
              text: '${Formatter.daysAgo(lastRun)} days ago',
              color: Palette.textSecondary,
            ),
          ],
        );
      default:
        return const Empty();
    }
  }
}

enum TestCaseColumn { name, executionType, lastRun }
