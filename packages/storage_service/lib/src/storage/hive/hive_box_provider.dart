import 'package:hive/hive.dart';

import 'path_provider.dart';

const _kHiveBoxKey = "hive_box";

class HiveBoxProvider {
  Box? _box;

  final String _boxKey;

  HiveBoxProvider({required String boxKey}) : _boxKey = boxKey;

  static HiveBoxProvider mainBoxProvider() => HiveBoxProvider(boxKey: _kHiveBoxKey);

  Future<Box> getBox() async {
    if (_box?.isOpen == true) {
      return _box!;
    }
    _box = await Hive.openBox(_boxKey);
    return _box!;
  }

  static Future<void> init({PathProvider pathProvider = const DefaultPathProvider()}) async {
    final appSupportDirectory = await pathProvider.getDocumentsDirectory();
    Hive.init(appSupportDirectory.path);
  }
}
