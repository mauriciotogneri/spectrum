import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:testflow/domain/state/components/components_state.dart';
import 'package:testflow/presentation/common/card/custom_card.dart';
import 'package:testflow/presentation/common/input/custom_text_input.dart';
import 'package:testflow/presentation/common/page/pane.dart';
import 'package:testflow/presentation/common/text/body_large.dart';
import 'package:testflow/presentation/common/text/body_medium.dart';
import 'package:testflow/presentation/common/text/body_small.dart';
import 'package:testflow/presentation/common/text/title_large.dart';
import 'package:testflow/presentation/common/text/title_medium.dart';
import 'package:testflow/presentation/common/text/title_small.dart';

class ComponentsView extends StatelessWidget {
  final ComponentsState state;

  const ComponentsView._(this.state);

  factory ComponentsView.instance() => ComponentsView._(ComponentsState());

  @override
  Widget build(BuildContext context) {
    return StateProvider<ComponentsState>(
      state: state,
      builder:
          (context, state) => Pane.normal(
            header: const Text('COMPONENTS'),
            content: Content(state),
          ),
    );
  }
}

class Content extends StatelessWidget {
  final ComponentsState state;

  const Content(this.state);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const VBox(16),
        const Texts(),
        const VBox(16),
        TextInputs(state),
        const VBox(16),
        TextInputForm(state),
        const VBox(16),
        DropdownFields(state),
      ],
    );
  }
}

class Texts extends StatelessWidget {
  const Texts();

  @override
  Widget build(BuildContext context) {
    return const CustomCard(
      expand: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          TitleLarge(text: 'Title large'),
          VBox(8),
          TitleMedium(text: 'Title medium'),
          VBox(8),
          TitleSmall(text: 'Title small'),
          VBox(8),
          BodyLarge(text: 'Body large'),
          VBox(8),
          BodyMedium(text: 'Body medium'),
          VBox(8),
          BodySmall(text: 'Body small'),
        ],
      ),
    );
  }
}

class TextInputs extends StatelessWidget {
  final ComponentsState state;

  const TextInputs(this.state);

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      expand: true,
      child: Row(
        children: [
          CustomTextInput(
            width: 300,
            hint: 'Query',
            canClear: true,
            controller: state.queryFilterController,
            onChange: (_) => state.notify(),
            prefixIcon: const TextInputIcon(Icons.question_mark),
          ),
        ],
      ),
    );
  }
}

class TextInputForm extends StatelessWidget {
  final ComponentsState state;

  const TextInputForm(this.state);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: state.form1Key,
      child: const Row(
        children: [
          /*CustomTextInput(
            width: 300,
            hint: 'Query',
            controller: state.queryFilterController,
            onChange: (_) => state.notify(),
            prefixIcon: const TextInputIcon(Icons.email_outlined),
          ),*/
        ],
      ),
    );
  }
}

class DropdownFields extends StatelessWidget {
  final ComponentsState state;

  const DropdownFields(this.state);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: state.form2Key,
      child: const Row(children: [Text('Dropdown')]),
    );
  }
}
