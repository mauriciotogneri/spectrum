import 'package:flutter/material.dart';
import 'package:testflow/presentation/common/chip/custom_chip.dart';
import 'package:testflow/presentation/common/input/custom_dropdown_single.dart';
import 'package:testflow/utils/palette.dart';

enum TestSessionStatus implements Chipable {
  pending,
  in_progress,
  finished;

  String get localized {
    switch (this) {
      case TestSessionStatus.pending:
        return 'Pending';
      case TestSessionStatus.in_progress:
        return 'In Progress';
      case TestSessionStatus.finished:
        return 'Finished';
    }
  }

  Color get foregroundColor {
    switch (this) {
      case TestSessionStatus.pending:
        return Palette.chipRedForeground;
      case TestSessionStatus.in_progress:
        return Palette.chipBlueForeground;
      case TestSessionStatus.finished:
        return Palette.chipGreenForeground;
    }
  }

  Color get backgroundColor {
    switch (this) {
      case TestSessionStatus.pending:
        return Palette.chipRedBackground;
      case TestSessionStatus.in_progress:
        return Palette.chipBlueBackground;
      case TestSessionStatus.finished:
        return Palette.chipGreenBackground;
    }
  }

  Color get borderColor {
    switch (this) {
      case TestSessionStatus.pending:
        return Palette.chipRedBorder;
      case TestSessionStatus.in_progress:
        return Palette.chipBlueBorder;
      case TestSessionStatus.finished:
        return Palette.chipGreenBorder;
    }
  }

  @override
  CustomChip get chip => CustomChip(
    text: localized,
    backgroundColor: backgroundColor,
    foregroundColor: foregroundColor,
    borderColor: borderColor,
  );

  static List<DropdownItem<TestSessionStatus>> get items =>
      TestSessionStatus.values
          .map((type) => DropdownItem(value: type, text: type.localized))
          .toList();

  @override
  String toString() => localized;
}
