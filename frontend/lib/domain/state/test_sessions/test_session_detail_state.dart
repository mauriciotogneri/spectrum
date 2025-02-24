import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:testflow/debug/data.dart';
import 'package:testflow/domain/model/test_session.dart';
import 'package:testflow/presentation/dialogs/base_dialog.dart';
import 'package:testflow/presentation/dialogs/confirmation_dialog.dart';
import 'package:testflow/utils/palette.dart';

class TestSessionDetailState extends BaseState {
  final String projectId;
  final String testSessionId;
  TestSession? _testSession;

  TestSessionDetailState({
    required this.projectId,
    required this.testSessionId,
  });

  TestSession get testSession => _testSession!;

  bool get isLoading => _testSession == null;

  @override
  void onLoad() {
    _testSession = Data.testSessionById(testSessionId);
    notify();
  }

  void onDeleteTestSession(BuildContext context) => BaseDialog.show(
    context: context,
    dialog: ConfirmationDialog(
      message: 'Do you want to delete the session?',
      acceptButtonText: 'Delete',
      acceptButtonColor: Palette.borderButtonError,
      onAccept:
          () => _deleteTestSession(context: context, testSession: testSession),
    ),
  );

  void _deleteTestSession({
    required BuildContext context,
    required TestSession testSession,
  }) {
    Data.deleteTestSession(testSession);
    Navigator.of(context).pop();
  }
}
