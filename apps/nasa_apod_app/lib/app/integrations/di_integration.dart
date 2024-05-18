import 'package:core_architecture/core_architecture.dart';
import 'package:flutter/foundation.dart';

import 'app_integration.dart';
import 'di/app_container.dart';

class DIIntegration with AppIntegration {
  final GetIt _getIt;

  const DIIntegration(this._getIt);

  @override
  Future<void> setUp() {
    AppContainer(_getIt)..register();

    return SynchronousFuture(null);
  }
}
