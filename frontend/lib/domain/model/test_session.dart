import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:testflow/domain/types/test_session_status.dart';
import 'package:testflow/extensions/string_extension.dart';
import 'package:testflow/presentation/common/chip/custom_chip.dart';
import 'package:testflow/presentation/common/table/custom_table.dart';
import 'package:testflow/presentation/common/text/body_medium.dart';

class TestSession implements TableElement {
  final String id;
  final String testSuiteId;
  final String name;
  final DateTime? startedOn;
  final DateTime? endedOn;
  final int timeSpent;
  final TestSessionStatus status;
  final String environment;
  final String platform;
  final String device;
  final String version;
  final DateTime createdOn;
  final String createdBy;
  final DateTime updatedOn;
  final String updatedBy;

  const TestSession({
    required this.id,
    required this.testSuiteId,
    required this.name,
    required this.startedOn,
    required this.endedOn,
    required this.timeSpent,
    required this.status,
    required this.environment,
    required this.platform,
    required this.device,
    required this.version,
    required this.createdOn,
    required this.createdBy,
    required this.updatedOn,
    required this.updatedBy,
  });

  bool matches({
    required String queryFilter,
    required List<TestSessionStatus> statusFilter,
    required List<String> environmentFilter,
    required List<String> platformFilter,
    required List<String> deviceFilter,
  }) {
    if (queryFilter.isEmpty &&
        statusFilter.isEmpty &&
        environmentFilter.isEmpty &&
        platformFilter.isEmpty &&
        deviceFilter.isEmpty) {
      return true;
    } else {
      final bool matchesQuery =
          queryFilter.isEmpty ||
          name.matches(queryFilter) ||
          environmentFilter.any((e) => e.matches(queryFilter)) ||
          platformFilter.any((e) => e.matches(queryFilter)) ||
          deviceFilter.any((e) => e.matches(queryFilter));
      final bool matchesStatus =
          statusFilter.isEmpty || statusFilter.contains(status);
      final bool matchesEnvironment =
          environmentFilter.isEmpty || environmentFilter.contains(environment);
      final bool matchesPlatform =
          platformFilter.isEmpty || platformFilter.contains(platform);
      final bool matchesDevice =
          deviceFilter.isEmpty || deviceFilter.contains(device);

      return matchesQuery &&
          matchesStatus &&
          matchesEnvironment &&
          matchesPlatform &&
          matchesDevice;
    }
  }

  @override
  String toString() => name;

  static List<TableColumn> get columns => const [
    TableColumn(id: TestSessionColumn.name, name: 'Name'),
    TableColumn(
      id: TestSessionColumn.status,
      name: 'Status',
      width: 200,
      alignment: Alignment.center,
    ),
    TableColumn(
      id: TestSessionColumn.environment,
      name: 'Environment',
      width: 200,
      alignment: Alignment.center,
    ),
    TableColumn(
      id: TestSessionColumn.platform,
      name: 'Platform',
      width: 200,
      alignment: Alignment.center,
    ),
    TableColumn(
      id: TestSessionColumn.device,
      name: 'Device',
      width: 200,
      alignment: Alignment.center,
    ),
    TableColumn(
      id: TestSessionColumn.version,
      name: 'Version',
      width: 200,
      alignment: Alignment.center,
    ),
  ];

  @override
  Widget cell(TableColumn column) {
    switch (column.id) {
      case TestSessionColumn.name:
        return BodyMedium(text: name);
      case TestSessionColumn.status:
        return status.chip;
      case TestSessionColumn.environment:
        return CustomChip(text: environment);
      case TestSessionColumn.platform:
        return CustomChip(text: platform);
      case TestSessionColumn.device:
        return CustomChip(text: device);
      case TestSessionColumn.version:
        return CustomChip(text: version);
      default:
        return const Empty();
    }
  }
}

enum TestSessionColumn { name, status, environment, platform, device, version }
