import 'package:core_architecture/core_architecture.dart';
import 'package:network_service/network_service.dart';
import 'package:storage_service/storage_service.dart';

import '../environment/environment.dart';

class AppContainer {
  final GetIt _getIt;

  const AppContainer(this._getIt);

  T _get<T extends Object>() {
    return _getIt.get();
  }

  void register() {
    _getIt.registerLazySingleton(() {
      final dio = Dio();
      dio.options.responseType = ResponseType.bytes;
      dio.options.queryParameters = {"api_key": Environment.config.apikey};
      dio.options.baseUrl = Environment.config.baseHost;
      return dio;
    });

    _getIt.registerFactory(() => NetworkService(_get()));

    _getIt.registerSingleton(HiveKeyValueStorage() as KeyValueStorage);

    _getIt.registerSingleton(StorageService(_get()));
  }
}
