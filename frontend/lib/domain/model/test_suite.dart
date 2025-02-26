import 'package:flutter/material.dart';
import 'package:testflow/domain/types/requirement_importance.dart';
import 'package:testflow/domain/types/requirement_type.dart';
import 'package:testflow/extensions/string_extension.dart';
import 'package:testflow/presentation/common/chip/custom_chip.dart';
import 'package:testflow/presentation/common/menu/context_menu.dart';
import 'package:testflow/presentation/common/table/custom_table.dart';
import 'package:testflow/presentation/common/text/body_medium.dart';
import 'package:testflow/utils/palette.dart';

class TestSuite
    implements TableElement<TestSuite, TestSuiteColumn, TestSuiteMenu> {
  final String id;
  final String name;
  final List<RequirementType> types;
  final List<RequirementImportance> importances;
  final List<String> components;
  final List<String> platforms;
  final List<String> tags;
  final DateTime createdOn;
  final String createdBy;
  final DateTime updatedOn;
  final String updatedBy;

  const TestSuite({
    required this.id,
    required this.name,
    required this.types,
    required this.importances,
    required this.components,
    required this.platforms,
    required this.tags,
    required this.createdOn,
    required this.createdBy,
    required this.updatedOn,
    required this.updatedBy,
  });

  bool matches({
    required String queryFilter,
    required List<RequirementType> typeFilter,
    required List<RequirementImportance> importanceFilter,
    required List<String> componentFilter,
    required List<String> platformFilter,
  }) {
    if (queryFilter.isEmpty &&
        typeFilter.isEmpty &&
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
      final bool matchesImportance =
          importanceFilter.isEmpty ||
          importanceFilter.any(importances.contains);
      final bool matchesComponent =
          componentFilter.isEmpty || componentFilter.any(components.contains);
      final bool matchesPlatform =
          platformFilter.isEmpty || platformFilter.any(platforms.contains);

      return matchesQuery &&
          matchesType &&
          matchesImportance &&
          matchesComponent &&
          matchesPlatform;
    }
  }

  @override
  String toString() => name;

  static List<TableColumn<TestSuiteColumn>> get columns => const [
    TableColumn(id: TestSuiteColumn.name, name: 'Name'),
    TableColumn(
      id: TestSuiteColumn.components,
      name: 'Component',
      width: 200,
      alignment: Alignment.center,
    ),
    TableColumn(
      id: TestSuiteColumn.platforms,
      name: 'Platform',
      width: 200,
      alignment: Alignment.center,
    ),
    TableColumn(
      id: TestSuiteColumn.types,
      name: 'Type',
      width: 200,
      alignment: Alignment.center,
    ),
    TableColumn(
      id: TestSuiteColumn.importances,
      name: 'Importance',
      width: 200,
      alignment: Alignment.center,
    ),
    TableColumn(
      id: TestSuiteColumn.menu,
      name: '',
      width: 100,
      alignment: Alignment.center,
    ),
  ];

  @override
  Widget cell({
    required TableColumn<TestSuiteColumn> column,
    required Function(TestSuite, TestSuiteMenu)? onMenuSelected,
  }) {
    switch (column.id) {
      case TestSuiteColumn.name:
        return BodyMedium(text: name);
      case TestSuiteColumn.types:
        return ChipGroup(items: types, plural: 'types');
      case TestSuiteColumn.importances:
        return ChipGroup(items: importances, plural: 'importances');
      case TestSuiteColumn.components:
        return ChipGroup(items: components, plural: 'components');
      case TestSuiteColumn.platforms:
        return ChipGroup(items: platforms, plural: 'platforms');
      case TestSuiteColumn.menu:
        return ContextMenu(
          type: ContextButton.iconButton,
          offset: const Offset(-100, 0),
          icon: Icons.more_vert_sharp,
          children: [
            ContextMenuItem(
              icon: Icons.play_arrow,
              text: 'Start session',
              color: Palette.textTitle,
              onPressed:
                  () => onMenuSelected?.call(this, TestSuiteMenu.startSession),
            ),
          ],
        );
    }
  }
}

enum TestSuiteColumn { name, types, importances, components, platforms, menu }

enum TestSuiteMenu { startSession }
