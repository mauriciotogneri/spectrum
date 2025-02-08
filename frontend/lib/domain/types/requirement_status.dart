import 'package:flutter/material.dart';

enum RequirementStatus {
  draft,
  active,
  inactive;

  String get localized {
    switch (this) {
      case RequirementStatus.draft:
        return 'Draft';
      case RequirementStatus.active:
        return 'Active';
      case RequirementStatus.inactive:
        return 'Inactive';
    }
  }

  Color get foregroundColor {
    switch (this) {
      case RequirementStatus.draft:
        return const Color(0xff515055);
      case RequirementStatus.active:
        return const Color(0xff38683A);
      case RequirementStatus.inactive:
        return const Color(0xff9C4238);
    }
  }

  Color get backgroundColor {
    switch (this) {
      case RequirementStatus.draft:
        return const Color(0xffEFEEF1);
      case RequirementStatus.active:
        return const Color(0xffEDF8EC);
      case RequirementStatus.inactive:
        return const Color(0xffFDE9E6);
    }
  }

  @override
  String toString() => localized;
}
