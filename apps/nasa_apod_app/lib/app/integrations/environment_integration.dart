import 'app_integration.dart';
import 'environment/environment.dart';

class EnvironmentIntegration with AppIntegration {
  @override
  Future<void> setUp() {
    return Environment.load();
  }
}
