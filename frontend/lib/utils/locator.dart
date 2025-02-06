import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:testflow/utils/navigation.dart';

final GetIt locator = GetIt.instance;

class Locator {
  static Future initialize() async {
    WidgetsFlutterBinding.ensureInitialized();

    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    /*await Firebase.initializeApp();

    await FirebaseConfig.appCheck().activate(
      androidProvider: environment.isDebugMode
          ? AndroidProvider.debug
          : AndroidProvider.playIntegrity,
    );*/

    //ErrorHandler.setup();

    //locator.registerSingleton<Environment>(environment);
    locator.registerSingleton<Navigation>(Navigation());
  }
}
