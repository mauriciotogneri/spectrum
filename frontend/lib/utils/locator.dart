import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:get_it/get_it.dart';
import 'package:testflow/domain/events/events.dart';
import 'package:testflow/environments/environment.dart';
import 'package:testflow/utils/error_handler.dart';
import 'package:testflow/utils/navigation.dart';

final GetIt locator = GetIt.instance;

class Locator {
  static Future initialize(Environment environment) async {
    WidgetsFlutterBinding.ensureInitialized();

    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyCI5bs6Lj7jlkLlk9D3m30d0P9_GIytGPo',
        authDomain: 'max-prototypes.firebaseapp.com',
        projectId: 'max-prototypes',
        storageBucket: 'max-prototypes.firebasestorage.app',
        messagingSenderId: '203891364336',
        appId: '1:203891364336:web:6b78978545e7bde6648d35',
      ),
    );

    ErrorHandler.setup();

    setUrlStrategy(PathUrlStrategy());

    locator.registerSingleton<Environment>(environment);
    locator.registerSingleton<Navigation>(Navigation());
    locator.registerSingleton<Events>(Events());

    await environment.configure();
  }
}
