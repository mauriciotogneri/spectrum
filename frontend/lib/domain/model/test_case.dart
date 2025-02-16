import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:testflow/domain/model/requirement.dart';
import 'package:testflow/presentation/common/table/custom_table.dart';

class TestCase implements TableElement {
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
  Widget cell(TableColumn column) {
    /*switch (column) {
      case 0:
        return BodyMedium(text: name);
      case 1:
        return CustomChip(text: isAutomated ? 'Yes' : 'No');
      case 2:
        return BodyMedium(text: Formatter.fullDateTime(lastRun));
      default:
        return const Empty();
    }*/
    return const Empty();
  }
}
