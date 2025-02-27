import 'package:dafluta/dafluta.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:testflow/persistence/authentication/authentication.dart';

class SplashState extends BaseState {
  @override
  void onLoad() {
    Authentication.checkIfAuthenticated(
      onSuccess: _onAuthenticated,
      onError: _onNotAuthenticated,
    );
  }

  void _onAuthenticated(User user) {}

  void _onNotAuthenticated() {}

  /*void init(BuildContext context) {
    if (Platform.isDebug) {
      Delayed.post(() => context.dashboard(projectId: Data.currentProject.id));
    } else {
      Delayed.post(() => context.signIn());
    }
  }*/
}
