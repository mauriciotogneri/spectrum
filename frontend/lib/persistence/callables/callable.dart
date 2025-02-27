import 'package:cloud_functions/cloud_functions.dart';
import 'package:testflow/environments/environment.dart';
import 'package:testflow/persistence/authentication/authentication.dart';
import 'package:testflow/utils/firebase_config.dart';
import 'package:testflow/utils/log.dart';

abstract class Callable {
  final String name;

  const Callable(this.name);

  Map<String, dynamic> _removeNullValues(Map<String, dynamic> map) {
    map.removeWhere((key, value) {
      if (value == null) {
        return true;
      } else if (value is Map<String, dynamic>) {
        _removeNullValues(value);

        return false;
      } else if (value is List) {
        value.removeWhere((element) {
          if (element == null) {
            return true;
          } else if (element is Map<String, dynamic>) {
            _removeNullValues(element);
            return false;
          }

          return false;
        });

        return false;
      }

      return false;
    });

    return map;
  }

  Future<HttpsCallableResult<T>> invoke<T>([
    CallableParameters? parameters,
    bool removeNullValues = true,
  ]) async {
    Log.trace('Callable', '$name started');

    try {
      await Authentication.reloadToken();

      final HttpsCallableOptions? options =
          Environment.get.isLocal
              ? HttpsCallableOptions(timeout: const Duration(seconds: 540))
              : null;

      final HttpsCallable callable = _callable(name: name, options: options);
      final Map<String, dynamic>? mapParameters = parameters?.toJson();
      final dynamic callableParameters =
          (mapParameters != null)
              ? (removeNullValues
                  ? _removeNullValues(mapParameters)
                  : mapParameters)
              : null;

      final HttpsCallableResult<T> result = await callable.call(
        callableParameters,
      );

      await Authentication.reloadToken();

      return result;
    }  finally {
      Log.trace('Callable', '$name finished');
    }
  }

  HttpsCallable _callable({
    required String name,
    required HttpsCallableOptions? options,
  }) {
    if (Environment.get.isLocal) {
      return FirebaseConfig.functions().httpsCallableFromUrl(
        'http://${Environment.get.localhost}:5001/local/${FirebaseConfig.REGION}/$name',
        options: options,
      );
    } else {
      return FirebaseConfig.functions().httpsCallable(name, options: options);
    }
  }
}

abstract class CallableParameters {
  const CallableParameters();

  Map<String, dynamic> toJson();
}
