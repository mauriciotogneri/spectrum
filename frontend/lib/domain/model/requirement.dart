import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:testflow/domain/model/custom_table_cell.dart';
import 'package:testflow/domain/types/importance.dart';
import 'package:testflow/extensions/string_extension.dart';
import 'package:testflow/presentation/common/chip/custom_chip.dart';

class Requirement implements CustomTableCell {
  final String name;
  final String description;
  final String component;
  final List<String> platforms;
  final Importance importance;
  final List<String> tags;

  const Requirement({
    required this.name,
    required this.description,
    required this.component,
    required this.platforms,
    required this.importance,
    required this.tags,
  });

  bool matches({
    required String queryFilter,
    required List<String> componentFilter,
    required List<String> platformFilter,
    required List<Importance> importanceFilter,
  }) {
    if (queryFilter.isEmpty &&
        componentFilter.isEmpty &&
        platformFilter.isEmpty &&
        importanceFilter.isEmpty) {
      return true;
    } else {
      final bool matchesQuery = queryFilter.isEmpty ||
          name.matches(queryFilter) ||
          description.matches(queryFilter) ||
          component.matches(queryFilter) ||
          platformFilter.any((platform) => platform.matches(queryFilter)) ||
          tags.any((tag) => tag.matches(queryFilter));
      final bool matchesComponent =
          componentFilter.isEmpty || componentFilter.contains(component);
      final bool matchesPlatform =
          platformFilter.isEmpty || platformFilter.any(platforms.contains);
      final bool matchesImportance =
          importanceFilter.isEmpty || importanceFilter.contains(importance);

      return matchesQuery &&
          matchesComponent &&
          matchesPlatform &&
          matchesImportance;
    }
  }

  @override
  Widget cell(int column) {
    switch (column) {
      case 0:
        return Text(name);
      case 1:
        return CustomChip(text: component);
      case 2:
        return ChipRow(chips: platforms);
      case 3:
        return CustomChip(
          text: importance.localized,
          foregroundColor: importance.foregroundColor,
          backgroundColor: importance.backgroundColor,
        );
      case 4:
        return ChipRow(chips: tags);
      default:
        return const Empty();
    }
  }

  @override
  String toString() => name;
}
