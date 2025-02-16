import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:testflow/debug/data.dart';
import 'package:testflow/domain/model/custom_table_cell.dart';
import 'package:testflow/domain/types/requirement_importance.dart';
import 'package:testflow/domain/types/requirement_status.dart';
import 'package:testflow/domain/types/requirement_type.dart';
import 'package:testflow/extensions/string_extension.dart';
import 'package:testflow/presentation/common/chip/custom_chip.dart';
import 'package:testflow/presentation/common/text/body_medium.dart';

class Requirement implements CustomTableCell {
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
          name.matches(queryFilter) ||
          description.matches(queryFilter) ||
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
  Widget cell(int column) {
    switch (column) {
      case 0:
        return BodyMedium(text: id);
      case 1:
        return BodyMedium(text: name);
      case 2:
        return CustomChip(text: component);
      case 3:
        return CustomChip(
          text: type.localized,
          foregroundColor: type.foregroundColor,
          backgroundColor: type.backgroundColor,
        );
      case 4:
        return CustomChip(
          text: status.localized,
          foregroundColor: status.foregroundColor,
          backgroundColor: status.backgroundColor,
        );
      case 5:
        return importance.chip;
      case 6:
        return BodyMedium(text: numberOfTestCases.toString());
      default:
        return const Empty();
    }
  }

  @override
  String toString() => name;
}
