import 'package:core_architecture/core_architecture.dart';
import 'package:network_service/network_service.dart';
import 'package:storage_service/storage_service.dart';

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
      dio.options.baseUrl = "https://api.nasa.gov/planetary";
      return dio;
    });

    _getIt.registerFactory(() => NetworkService(_get()));

    _getIt.registerSingleton(HiveKeyValueStorage() as KeyValueStorage);

    _getIt.registerSingleton(StorageService(_get()));
  }
}
