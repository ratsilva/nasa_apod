import 'package:core_architecture/core_architecture.dart';

import 'di_integration.dart';
import 'environment_integration.dart';
import 'hive_integration.dart';

/// Defines what a [appIntegration] is.
///
/// Every app integrationin the project need to conform to this protocol and will be called during
/// the app initialization.
mixin AppIntegration {
  Future<void> setUp();
}

/// Order is important
final appIntegrations = (GetIt getIt) => [
      EnvironmentIntegration(),
      HiveIntegration(),
      DIIntegration(getIt),
    ];
