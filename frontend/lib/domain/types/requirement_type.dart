import 'package:flutter/material.dart';
import 'package:testflow/presentation/common/chip/custom_chip.dart';
import 'package:testflow/utils/palette.dart';

enum RequirementType {
  functional,
  non_functional;

  String get localized {
    switch (this) {
      case RequirementType.functional:
        return 'Functional';
      case RequirementType.non_functional:
        return 'Non Functional';
    }
  }

  Color get foregroundColor {
    switch (this) {
      case RequirementType.functional:
        return Palette.chipGreenForeground;
      case RequirementType.non_functional:
        return Palette.chipBlueForeground;
    }
  }

  Color get backgroundColor {
    switch (this) {
      case RequirementType.functional:
        return Palette.chipGreenBackground;
      case RequirementType.non_functional:
        return Palette.chipBlueBackground;
    }
  }

  CustomChip get chip => CustomChip(
    text: localized,
    backgroundColor: backgroundColor,
    foregroundColor: foregroundColor,
  );

  @override
  String toString() => localized;
}
