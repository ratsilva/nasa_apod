import 'package:core_architecture/core_architecture.dart';

class NasaPictureContainer {
  final GetIt _getIt;

  const NasaPictureContainer(this._getIt);

  T _get<T extends Object>() {
    return _getIt.get();
  }

  void register() {}
}
