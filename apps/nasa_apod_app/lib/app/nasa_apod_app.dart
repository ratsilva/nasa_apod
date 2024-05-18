import 'package:core_architecture/core_architecture.dart';
import 'package:flutter/material.dart';

class NasaApodApp extends StatelessWidget {
  final GoRouter router;
  const NasaApodApp({Key? key, required this.router}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      title: "Nasa APOD App",
      debugShowCheckedModeBanner: false,
    );
  }
}
