import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:testflow/domain/state/test_sessions/test_session_detail_state.dart';
import 'package:testflow/presentation/common/layout/pane.dart';
import 'package:testflow/presentation/common/menu/context_menu.dart';
import 'package:testflow/presentation/common/navigation/navigation_path.dart';
import 'package:testflow/utils/navigation.dart';
import 'package:testflow/utils/palette.dart';

class TestSessionDetailPage extends StatelessWidget {
  final TestSessionDetailState state;

  const TestSessionDetailPage._(this.state);

  factory TestSessionDetailPage.instance({
    required String projectId,
    required String testSessionId,
  }) => TestSessionDetailPage._(
    TestSessionDetailState(projectId: projectId, testSessionId: testSessionId),
  );

  @override
  Widget build(BuildContext context) {
    return StateProvider<TestSessionDetailState>(
      state: state,
      builder:
          (context, state) => state.isLoading ? const Empty() : Content(state),
    );
  }
}

class Content extends StatelessWidget {
  final TestSessionDetailState state;

  const Content(this.state);

  @override
  Widget build(BuildContext context) {
    return Pane.scrollable(children: [Header(state), Body(state)]);
  }
}

class Header extends StatelessWidget {
  final TestSessionDetailState state;

  const Header(this.state);

  @override
  Widget build(BuildContext context) {
    return PaneHeader(
      path: NavigationPath(
        paths: [
          PathItem(
            text: 'Sessions',
            path: Navigation.testSessionListPath(projectId: state.projectId),
          ),
          PathItem(text: state.testSession.id),
        ],
      ),
      actions: [
        ContextMenu(
          offset: const Offset(-85, 0),
          icon: Icons.more_horiz,
          children: [
            ContextMenuItem(
              icon: Icons.delete_outline,
              text: 'Delete',
              color: Palette.semanticError,
              onPressed: () => state.onDeleteTestSession(context),
            ),
          ],
        ),
      ],
    );
  }
}

class Body extends StatelessWidget {
  final TestSessionDetailState state;

  const Body(this.state);

  @override
  Widget build(BuildContext context) {
    return const Empty();
  }
}
