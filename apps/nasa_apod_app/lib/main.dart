import 'package:core_architecture/core_architecture.dart';
import 'package:flutter/material.dart';

import 'app/integrations/app_integration.dart';
import 'app/nasa_apod_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final getIt = GetIt.instance;

  for (final integration in appIntegrations(getIt)) {
    await integration.setUp();
  }

  runApp(NasaApodApp());
}
