import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:testflow/debug/data.dart';
import 'package:testflow/domain/model/requirement.dart';

class RequirementsState extends BaseState {
  final TextEditingController filterController = TextEditingController();
  final FocusNode componentFocusNode = FocusNode();
  final FocusNode platformFocusNode = FocusNode();
  final List<Requirement> _allRequirements = Data.requirements();

  String? componentFilter;
  String? platformFilter;

  List<Requirement> get requirements {
    final String query = filterController.text.trim().toLowerCase();

    return _allRequirements
        .where((requirement) => requirement.matches(
              query: query,
              component: componentFilter ?? '',
              platform: platformFilter ?? '',
            ))
        .toList();
  }

  void onComponentFilterChanged(String? value) {
    componentFilter = value;
    notify();
  }

  void onPlatformFilterChanged(String? value) {
    platformFilter = value;
    notify();
  }

  void onRequirementSelected(Requirement requirement) {
    print(requirement);
  }
}
