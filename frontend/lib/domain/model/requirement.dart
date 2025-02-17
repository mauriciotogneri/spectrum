import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:testflow/debug/data.dart';
import 'package:testflow/domain/types/requirement_importance.dart';
import 'package:testflow/domain/types/requirement_status.dart';
import 'package:testflow/domain/types/requirement_type.dart';
import 'package:testflow/extensions/string_extension.dart';
import 'package:testflow/presentation/common/chip/custom_chip.dart';
import 'package:testflow/presentation/common/table/custom_table.dart';
import 'package:testflow/presentation/common/text/body_medium.dart';

class Requirement implements TableElement {
  final String id;
  final RequirementType type;
  final RequirementStatus status;
  final RequirementImportance importance;
  final String name;
  final String description;
  final String component;
  final List<String> platforms;
  final List<String> tags;

  const Requirement({
    required this.id,
    required this.type,
    required this.status,
    required this.importance,
    required this.name,
    required this.description,
    required this.component,
    required this.platforms,
    required this.tags,
  });

  int get numberOfTestCases => Data.testCases(this).length;

  bool matches({
    required String queryFilter,
    required List<RequirementType> typeFilter,
    required List<RequirementStatus> statusFilter,
    required List<String> componentFilter,
    required List<String> platformFilter,
    required List<RequirementImportance> importanceFilter,
  }) {
    if (queryFilter.isEmpty &&
        typeFilter.isEmpty &&
        statusFilter.isEmpty &&
        componentFilter.isEmpty &&
        platformFilter.isEmpty &&
        importanceFilter.isEmpty) {
      return true;
    } else {
      final bool matchesQuery =
          queryFilter.isEmpty ||
          id.matches(queryFilter) ||
          name.matches(queryFilter) ||
          description.matches(queryFilter) ||
          component.matches(queryFilter) ||
          tags.any((tag) => tag.matches(queryFilter));
      final bool matchesType = typeFilter.isEmpty || typeFilter.contains(type);
      final bool matchesStatus =
          statusFilter.isEmpty || statusFilter.contains(status);
      final bool matchesComponent =
          componentFilter.isEmpty || componentFilter.contains(component);
      final bool matchesPlatform =
          platformFilter.isEmpty || platformFilter.any(platforms.contains);
      final bool matchesImportance =
          importanceFilter.isEmpty || importanceFilter.contains(importance);

      return matchesQuery &&
          matchesType &&
          matchesStatus &&
          matchesComponent &&
          matchesPlatform &&
          matchesImportance;
    }
  }

  @override
  String toString() => name;

  static List<TableColumn> get columns => const [
    TableColumn(id: RequirementColumns.id, name: 'ID', width: 150),
    TableColumn(id: RequirementColumns.name, name: 'Name'),
    TableColumn(
      id: RequirementColumns.component,
      name: 'Component',
      width: 200,
      alignment: Alignment.center,
    ),
    TableColumn(
      id: RequirementColumns.platforms,
      name: 'Platforms',
      width: 200,
      alignment: Alignment.center,
    ),
    TableColumn(
      id: RequirementColumns.type,
      name: 'Type',
      width: 170,
      alignment: Alignment.center,
    ),
    TableColumn(
      id: RequirementColumns.status,
      name: 'Status',
      width: 130,
      alignment: Alignment.center,
    ),
    TableColumn(
      id: RequirementColumns.importance,
      name: 'Importance',
      width: 130,
      alignment: Alignment.center,
    ),
    TableColumn(
      id: RequirementColumns.numberOfTestCases,
      name: 'Test Cases',
      width: 120,
      alignment: Alignment.center,
    ),
  ];

  @override
  Widget cell(TableColumn column) {
    switch (column.id) {
      case RequirementColumns.id:
        return BodyMedium(text: id);
      case RequirementColumns.name:
        return BodyMedium(text: name);
      case RequirementColumns.component:
        return CustomChip(text: component);
      case RequirementColumns.platforms:
        if (platforms.isEmpty) {
          return const Empty();
        } else if (platforms.length == 1) {
          return CustomChip(text: platforms.first);
        } else {
          return CustomChip(text: '${platforms.length} platforms');
        }
      case RequirementColumns.type:
        return type.chip;
      case RequirementColumns.status:
        return status.chip;
      case RequirementColumns.importance:
        return importance.chip;
      case RequirementColumns.numberOfTestCases:
        return BodyMedium(text: numberOfTestCases.toString());
      default:
        return const Empty();
    }
  }
}

enum RequirementColumns {
  id,
  name,
  component,
  platforms,
  type,
  status,
  importance,
  numberOfTestCases,
}
