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
    required String query,
    required List<String> components,
    required List<String> platforms,
  }) {
    if (query.isEmpty && components.isEmpty && platforms.isEmpty) {
      return true;
    } else {
      final bool matchesQuery = query.isEmpty ||
          name.matches(query) ||
          description.matches(query) ||
          component.matches(query) ||
          platforms.any((platform) => platform.matches(query)) ||
          tags.any((tag) => tag.matches(query));
      final bool matchesComponent =
          components.isEmpty || components.contains(component);
      final bool matchesPlatform = platforms.isEmpty ||
          platforms.every(
            (platform) => this.platforms.contains(platform),
          );

      return matchesQuery && matchesComponent && matchesPlatform;
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
