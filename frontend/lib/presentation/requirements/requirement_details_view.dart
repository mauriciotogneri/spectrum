import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:testflow/domain/model/requirement.dart';
import 'package:testflow/domain/state/requirements/requirement_details_state.dart';
import 'package:testflow/presentation/common/text/title_4.dart';
import 'package:testflow/presentation/common/view/base_view.dart';
import 'package:testflow/utils/navigation.dart';

class RequirementDetailView extends StatelessWidget {
  final RequirementDetailsState state;

  const RequirementDetailView._(this.state);

  factory RequirementDetailView.instance({
    required Requirement requirement,
  }) =>
      RequirementDetailView._(
          RequirementDetailsState(requirement: requirement));

  @override
  Widget build(BuildContext context) {
    return StateProvider<RequirementDetailsState>(
      state: state,
      builder: (context, state) => BaseView(
        padding: const EdgeInsets.only(
          top: 16,
          left: 16,
          right: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Header(state),
          ],
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  final RequirementDetailsState state;

  const Header(this.state);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const ShadButton.outline(
          icon: Icon(Icons.keyboard_arrow_left_rounded),
          onPressed: Navigation.unstack,
        ),
        const HBox(8),
        Title4(text: 'Requirement: ${state.requirement.name}'),
      ],
    );
  }
}
