import 'package:storage_service/storage_service.dart';

import 'app_integration.dart';

class HiveIntegration with AppIntegration {
  @override
  Future<void> setUp() async {
    return HiveBoxProvider.init().catchError((_) {});
  }
}
