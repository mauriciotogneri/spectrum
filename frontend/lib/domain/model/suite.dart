import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:testflow/domain/types/requirement_importance.dart';
import 'package:testflow/domain/types/requirement_status.dart';
import 'package:testflow/domain/types/requirement_type.dart';
import 'package:testflow/extensions/string_extension.dart';
import 'package:testflow/presentation/common/chip/custom_chip.dart';
import 'package:testflow/presentation/common/table/custom_table.dart';
import 'package:testflow/presentation/common/text/body_medium.dart';

class Suite implements TableElement {
  final String id;
  final String name;
  final List<RequirementType> types;
  final List<RequirementStatus> statuses;
  final List<RequirementImportance> importances;
  final List<String> components;
  final List<String> platforms;
  final List<String> tags;

  const Suite({
    required this.id,
    required this.name,
    required this.types,
    required this.statuses,
    required this.importances,
    required this.components,
    required this.platforms,
    required this.tags,
  });

  bool matches({
    required String queryFilter,
    required List<RequirementType> typeFilter,
    required List<RequirementStatus> statusFilter,
    required List<RequirementImportance> importanceFilter,
    required List<String> componentFilter,
    required List<String> platformFilter,
  }) {
    if (queryFilter.isEmpty &&
        typeFilter.isEmpty &&
        statusFilter.isEmpty &&
        importanceFilter.isEmpty &&
        componentFilter.isEmpty &&
        platformFilter.isEmpty) {
      return true;
    } else {
      final bool matchesQuery =
          queryFilter.isEmpty ||
          name.matches(queryFilter) ||
          componentFilter.any((e) => e.matches(queryFilter)) ||
          platformFilter.any((e) => e.matches(queryFilter)) ||
          tags.any((e) => e.matches(queryFilter));
      final bool matchesType =
          typeFilter.isEmpty || typeFilter.any(types.contains);
      final bool matchesStatus =
          statusFilter.isEmpty || statusFilter.any(statuses.contains);
      final bool matchesImportance =
          importanceFilter.isEmpty ||
          importanceFilter.any(importances.contains);
      final bool matchesComponent =
          componentFilter.isEmpty || componentFilter.any(components.contains);
      final bool matchesPlatform =
          platformFilter.isEmpty || platformFilter.any(platforms.contains);

      return matchesQuery &&
          matchesType &&
          matchesStatus &&
          matchesImportance &&
          matchesComponent &&
          matchesPlatform;
    }
  }

  @override
  String toString() => name;

  static List<TableColumn> get columns => const [
    TableColumn(id: SuiteColumn.name, name: 'Name'),
    TableColumn(
      id: SuiteColumn.components,
      name: 'Component',
      width: 200,
      alignment: Alignment.center,
    ),
    TableColumn(
      id: SuiteColumn.platforms,
      name: 'Platform',
      width: 200,
      alignment: Alignment.center,
    ),
    TableColumn(
      id: SuiteColumn.types,
      name: 'Type',
      width: 200,
      alignment: Alignment.center,
    ),
    TableColumn(
      id: SuiteColumn.statuses,
      name: 'Status',
      width: 200,
      alignment: Alignment.center,
    ),
    TableColumn(
      id: SuiteColumn.importances,
      name: 'Importance',
      width: 200,
      alignment: Alignment.center,
    ),
  ];

  @override
  Widget cell(TableColumn column) {
    switch (column.id) {
      case SuiteColumn.name:
        return BodyMedium(text: name);
      case SuiteColumn.types:
        return ChipGroup(items: types, plural: 'types');
      case SuiteColumn.statuses:
        return ChipGroup(items: statuses, plural: 'statuses');
      case SuiteColumn.importances:
        return ChipGroup(items: importances, plural: 'importances');
      case SuiteColumn.components:
        return ChipGroup(items: components, plural: 'components');
      case SuiteColumn.platforms:
        return ChipGroup(items: platforms, plural: 'platforms');
      default:
        return const Empty();
    }
  }
}

enum SuiteColumn { name, types, statuses, importances, components, platforms }
