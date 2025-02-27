import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:testflow/environments/environment.dart';

class FirebaseConfig {
  static const String REGION = 'europe-west6';

  static FirebaseFunctions functions() =>
      FirebaseFunctions.instanceFor(app: Firebase.app(), region: REGION);

  static FirebaseAuth auth() => FirebaseAuth.instance;

  static FirebaseStorage storage() {
    if (Environment.get.isLocal) {
      return FirebaseStorage.instanceFor(bucket: 'gs://local.appspot.com');
    } else {
      return FirebaseStorage.instance;
    }
  }

  static FirebaseAnalytics analytics() => FirebaseAnalytics.instance;

  static FirebaseFirestore firestore() => FirebaseFirestore.instance;

  static FirebaseCrashlytics crashlytics() => FirebaseCrashlytics.instance;
}
