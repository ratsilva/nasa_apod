import 'package:core_architecture/core_architecture.dart';
import 'package:flutter/foundation.dart';
import 'package:nasa_picture/di/nasa_picture_container.dart';

import 'app_integration.dart';
import 'di/app_container.dart';

class DIIntegration with AppIntegration {
  final GetIt _getIt;

  const DIIntegration(this._getIt);

  @override
  Future<void> setUp() {
    AppContainer(_getIt)..register();
    NasaPictureContainer(_getIt)..register();

    return SynchronousFuture(null);
  }
}
