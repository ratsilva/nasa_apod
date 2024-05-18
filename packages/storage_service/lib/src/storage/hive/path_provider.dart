import 'dart:io';

import 'package:path_provider/path_provider.dart' as path;

/// Allows returning fake path providers for unit tests if needed.
abstract class PathProvider {
  Future<Directory> getDocumentsDirectory();
  Future<Directory> getApplicationSupportDirectory();
  Future<Directory> getTemporaryDirectory();
}

/// Default path provider using path_provider package
class DefaultPathProvider implements PathProvider {
  const DefaultPathProvider();
  @override
  Future<Directory> getDocumentsDirectory() => path.getApplicationDocumentsDirectory();

  @override
  Future<Directory> getApplicationSupportDirectory() => path.getApplicationSupportDirectory();

  @override
  Future<Directory> getTemporaryDirectory() => path.getTemporaryDirectory();
}
