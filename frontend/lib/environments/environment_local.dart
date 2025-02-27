import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:testflow/environments/environment.dart';
import 'package:testflow/utils/firebase_config.dart';

class LocalEnvironment extends Environment {
  @override
  String get name => 'local';

  @override
  Future configure() async {
    await FirebaseConfig.auth().useAuthEmulator(
      Environment.get.localhost,
      9099,
    );

    FirebaseConfig.functions().useFunctionsEmulator(
      Environment.get.localhost,
      5001,
    );

    FirebaseConfig.firestore().settings = Settings(
      host: '${Environment.get.localhost}:8080',
      sslEnabled: false,
      persistenceEnabled: false,
    );

    FirebaseConfig.firestore().useFirestoreEmulator(
      Environment.get.localhost,
      8080,
    );

    await FirebaseConfig.storage().useStorageEmulator(
      Environment.get.localhost,
      9199,
    );
  }
}
