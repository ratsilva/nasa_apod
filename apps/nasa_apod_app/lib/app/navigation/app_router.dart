import 'package:core_architecture/core_architecture.dart';
import 'package:flutter/material.dart';
import 'package:nasa_picture/nasa_picture.dart';

class AppRouter {
  final GetIt _getIt;
  final GlobalKey<NavigatorState> _rootNavigatorKey;

  AppRouter(
    this._getIt, {
    GlobalKey<NavigatorState>? navigatorKey,
  }) : this._rootNavigatorKey = navigatorKey ?? GlobalKey<NavigatorState>();

  GoRouter get router => GoRouter(
        initialLocation: NasaPictureRoutes.list.path,
        navigatorKey: _rootNavigatorKey,
        routes: [
          ..._getIt.get<NasaPictureNavigation>().routes,
        ],
      );
}
