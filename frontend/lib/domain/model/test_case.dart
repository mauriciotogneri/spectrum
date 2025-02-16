import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:testflow/domain/model/custom_table_cell.dart';
import 'package:testflow/domain/model/requirement.dart';
import 'package:testflow/presentation/common/chip/custom_chip.dart';
import 'package:testflow/presentation/common/text/body_medium.dart';
import 'package:testflow/utils/formatter.dart';

class TestCase implements CustomTableCell {
  final Requirement requirement;
  final String name;
  final bool isAutomated;
  final String preconditions;
  final String steps;
  final String expected;
  final DateTime lastRun;

  const TestCase({
    required this.requirement,
    required this.name,
    required this.isAutomated,
    required this.preconditions,
    required this.steps,
    required this.expected,
    required this.lastRun,
  });

  @override
  Widget cell(int column) {
    switch (column) {
      case 0:
        return BodyMedium(text: name);
      case 1:
        return CustomChip(text: isAutomated ? 'Yes' : 'No');
      case 2:
        return BodyMedium(text: Formatter.fullDateTime(lastRun));
      default:
        return const Empty();
    }
  }
}
