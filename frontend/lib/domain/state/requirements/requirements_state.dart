import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:testflow/debug/data.dart';
import 'package:testflow/domain/model/requirement.dart';

class RequirementsState extends BaseState {
  final TextEditingController queryFilterController = TextEditingController();
  final FocusNode componentFilterFocusNode = FocusNode();
  final FocusNode platformFilterFocusNode = FocusNode();
  final List<Requirement> _allRequirements = Data.requirements();
  final List<String> componentFilter = [];
  final List<String> platformFilter = [];

  List<Requirement> get requirements => _allRequirements
      .where((requirement) => requirement.matches(
            query: queryFilterController.text,
            components: componentFilter,
            platforms: platformFilter,
          ))
      .toList();

  void onQueryFilterChanged(String value) {
    notify();
  }

  void onComponentFilterChanged(List<String> value) {
    componentFilter.clear();
    componentFilter.addAll(value);
    notify();
  }

  void onPlatformFilterChanged(List<String> value) {
    platformFilter.clear();
    platformFilter.addAll(value);
    notify();
  }

  void onRequirementSelected(Requirement requirement) {
    print(requirement);
  }
}
