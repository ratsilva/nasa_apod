import 'dart:async';

import '../exception/key_value_storage_exception.dart';
import 'hive/hive_box_provider.dart';
import 'key_value_storage.dart';

/// [HiveKeyValueStorage] uses Hive to implement a storage following the [KeyValueStorage] API.
class HiveKeyValueStorage extends KeyValueStorage {
  final HiveBoxProvider _hiveBoxProvider;

  HiveKeyValueStorage({
    HiveBoxProvider? hiveBoxProvider,
  }) : this._hiveBoxProvider = hiveBoxProvider ?? HiveBoxProvider.mainBoxProvider();

  @override
  Future<Map<String, dynamic>> get(String key) async {
    final box = await _hiveBoxProvider.getBox();

    if (box.containsKey(key)) {
      return Map<String, dynamic>.from(box.get(key) as Map);
    } else {
      throw KeyValueStorageException.noValueFound(key);
    }
  }

  @override
  Future<Map<String, dynamic>> put(Map<String, dynamic> value, String key) async {
    final box = await _hiveBoxProvider.getBox();
    await box.put(key, value);
    return value;
  }

  @override
  Future<List<Map<String, dynamic>>> filter(String keyPrefix) async {
    final box = await _hiveBoxProvider.getBox();
    return box.keys
        .where((key) => (key as String).startsWith(keyPrefix))
        .map((key) => Map<String, dynamic>.from(box.get(key) as Map))
        .toList();
  }
}
