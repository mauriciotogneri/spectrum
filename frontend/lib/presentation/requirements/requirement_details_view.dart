import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:testflow/domain/model/requirement.dart';
import 'package:testflow/domain/state/requirements/requirement_details_state.dart';
import 'package:testflow/presentation/common/text/title_4.dart';
import 'package:testflow/presentation/common/view/base_view.dart';

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
      builder: (context, state) => BaseView.withBack(
        header: Title4(text: 'Requirement: ${state.requirement.name}'),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 200,
              color: Colors.red,
            )
          ],
        ),
      ),
    );
  }
}
