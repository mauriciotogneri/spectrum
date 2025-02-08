import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:testflow/domain/model/custom_table_cell.dart';
import 'package:testflow/domain/types/requirement_importance.dart';
import 'package:testflow/domain/types/requirement_status.dart';
import 'package:testflow/domain/types/requirement_type.dart';
import 'package:testflow/extensions/string_extension.dart';
import 'package:testflow/presentation/common/chip/custom_chip.dart';

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
  final int numberOfTestCases;

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
    required this.numberOfTestCases,
  });

  bool matches({
    required String queryFilter,
    required List<RequirementType> typeFilter,
    required List<String> componentFilter,
    required List<String> platformFilter,
    required List<RequirementImportance> importanceFilter,
  }) {
    if (queryFilter.isEmpty &&
        typeFilter.isEmpty &&
        componentFilter.isEmpty &&
        platformFilter.isEmpty &&
        importanceFilter.isEmpty) {
      return true;
    } else {
      final bool matchesQuery = queryFilter.isEmpty ||
          name.matches(queryFilter) ||
          description.matches(queryFilter) ||
          tags.any((tag) => tag.matches(queryFilter));
      final bool matchesType = typeFilter.isEmpty || typeFilter.contains(type);
      final bool matchesComponent =
          componentFilter.isEmpty || componentFilter.contains(component);
      final bool matchesPlatform =
          platformFilter.isEmpty || platformFilter.any(platforms.contains);
      final bool matchesImportance =
          importanceFilter.isEmpty || importanceFilter.contains(importance);

      return matchesType &&
          matchesQuery &&
          matchesComponent &&
          matchesPlatform &&
          matchesImportance;
    }
  }

  @override
  Widget cell(int column) {
    switch (column) {
      case 0:
        return Text(
          id,
          style: const TextStyle(
            overflow: TextOverflow.ellipsis,
          ),
        );
      case 1:
        return Text(
          name,
          style: const TextStyle(
            overflow: TextOverflow.ellipsis,
          ),
        );
      case 2:
        return CustomChip(
          text: type.localized,
          foregroundColor: type.foregroundColor,
          backgroundColor: type.backgroundColor,
        );
      case 3:
        return CustomChip(
          text: status.localized,
          foregroundColor: status.foregroundColor,
          backgroundColor: status.backgroundColor,
        );
      case 4:
        return CustomChip(text: component);
      case 5:
        return CustomChip(
          text: importance.localized,
          foregroundColor: importance.foregroundColor,
          backgroundColor: importance.backgroundColor,
        );
      case 6:
        return Text(numberOfTestCases.toString());
      default:
        return const Empty();
    }
  }

  @override
  String toString() => name;
}
