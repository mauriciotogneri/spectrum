import 'package:flutter/material.dart';
import 'package:testflow/presentation/common/chip/custom_chip.dart';
import 'package:testflow/presentation/common/input/custom_dropdown_single.dart';
import 'package:testflow/utils/palette.dart';

enum TestRunResult implements Chipable {
  pending,
  passed,
  skipped,
  blocked,
  failed;

  String get localized {
    switch (this) {
      case TestRunResult.pending:
        return 'Pending';
      case TestRunResult.passed:
        return 'Passed';
      case TestRunResult.skipped:
        return 'Skipped';
      case TestRunResult.blocked:
        return 'Blocked';
      case TestRunResult.failed:
        return 'Failed';
    }
  }

  Color get foregroundColor {
    switch (this) {
      case TestRunResult.pending:
        return Palette.chipWhiteForeground;
      case TestRunResult.passed:
        return Palette.chipGreenForeground;
      case TestRunResult.skipped:
        return Palette.chipBlueForeground;
      case TestRunResult.blocked:
        return Palette.chipYellowForeground;
      case TestRunResult.failed:
        return Palette.chipRedForeground;
    }
  }

  Color get backgroundColor {
    switch (this) {
      case TestRunResult.pending:
        return Palette.chipWhiteBackground;
      case TestRunResult.passed:
        return Palette.chipGreenBackground;
      case TestRunResult.skipped:
        return Palette.chipBlueBackground;
      case TestRunResult.blocked:
        return Palette.chipYellowBackground;
      case TestRunResult.failed:
        return Palette.chipRedBackground;
    }
  }

  Color get borderColor {
    switch (this) {
      case TestRunResult.pending:
        return Palette.chipWhiteBorder;
      case TestRunResult.passed:
        return Palette.chipGreenBorder;
      case TestRunResult.skipped:
        return Palette.chipBlueBorder;
      case TestRunResult.blocked:
        return Palette.chipYellowBorder;
      case TestRunResult.failed:
        return Palette.chipRedBorder;
    }
  }

  @override
  CustomChip get chip => CustomChip(
    text: localized,
    backgroundColor: backgroundColor,
    foregroundColor: foregroundColor,
    borderColor: borderColor,
  );

  static List<DropdownItem<TestRunResult>> get items =>
      TestRunResult.values
          .map((type) => DropdownItem(value: type, text: type.localized))
          .toList();

  @override
  String toString() => localized;
}
