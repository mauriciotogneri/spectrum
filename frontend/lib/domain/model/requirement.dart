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
  final String code;
  final String name;
  final String description;
  final String component;
  final List<String> platforms;
  final List<String> tags;
  final DateTime createdOn;
  final String createdBy;
  final DateTime updatedOn;
  final String updatedBy;

  const Requirement({
    required this.id,
    required this.type,
    required this.status,
    required this.importance,
    required this.code,
    required this.name,
    required this.description,
    required this.component,
    required this.platforms,
    required this.tags,
    required this.createdOn,
    required this.createdBy,
    required this.updatedOn,
    required this.updatedBy,
  });

  int get numberOfTestCases => Data.testCases(this).length;

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
          code.matches(queryFilter) ||
          name.matches(queryFilter) ||
          description.matches(queryFilter) ||
          component.matches(queryFilter) ||
          platforms.any((e) => e.matches(queryFilter)) ||
          tags.any((e) => e.matches(queryFilter));
      final bool matchesType = typeFilter.isEmpty || typeFilter.contains(type);
      final bool matchesStatus =
          statusFilter.isEmpty || statusFilter.contains(status);
      final bool matchesImportance =
          importanceFilter.isEmpty || importanceFilter.contains(importance);
      final bool matchesComponent =
          componentFilter.isEmpty || componentFilter.contains(component);
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
    TableColumn(id: RequirementColumn.id, name: 'Code', width: 150),
    TableColumn(id: RequirementColumn.name, name: 'Name'),
    TableColumn(
      id: RequirementColumn.component,
      name: 'Component',
      width: 200,
      alignment: Alignment.center,
    ),
    TableColumn(
      id: RequirementColumn.platforms,
      name: 'Platforms',
      width: 200,
      alignment: Alignment.center,
    ),
    TableColumn(
      id: RequirementColumn.type,
      name: 'Type',
      width: 200,
      alignment: Alignment.center,
    ),
    TableColumn(
      id: RequirementColumn.status,
      name: 'Status',
      width: 130,
      alignment: Alignment.center,
    ),
    TableColumn(
      id: RequirementColumn.importance,
      name: 'Importance',
      width: 130,
      alignment: Alignment.center,
    ),
    TableColumn(
      id: RequirementColumn.numberOfTestCases,
      name: 'Test Cases',
      width: 130,
      alignment: Alignment.center,
    ),
  ];

  @override
  Widget cell(TableColumn column) {
    switch (column.id) {
      case RequirementColumn.id:
        return BodyMedium(text: code);
      case RequirementColumn.name:
        return BodyMedium(text: name);
      case RequirementColumn.component:
        return CustomChip(text: component);
      case RequirementColumn.platforms:
        return ChipGroup(items: platforms, plural: 'platforms');
      case RequirementColumn.type:
        return type.chip;
      case RequirementColumn.status:
        return status.chip;
      case RequirementColumn.importance:
        return importance.chip;
      case RequirementColumn.numberOfTestCases:
        return BodyMedium(text: numberOfTestCases.toString());
      default:
        return const Empty();
    }
  }
}

enum RequirementColumn {
  id,
  name,
  component,
  platforms,
  type,
  status,
  importance,
  numberOfTestCases,
}
