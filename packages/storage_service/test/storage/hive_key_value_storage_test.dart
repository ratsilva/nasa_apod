import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/mockito.dart';
import 'package:storage_service/src/exception/key_value_storage_exception.dart';
import 'package:storage_service/src/storage/hive/path_provider.dart';
import 'package:storage_service/storage_service.dart';

import '../mocks/mocks.mocks.dart';

void main() {
  late String key;

  late KeyValueStorage storage;
  late PathProvider pathProvider;

  setUp(() async {
    key = "key";

    pathProvider = MockPathProvider();
    when(pathProvider.getDocumentsDirectory())
        .thenAnswer((_) => Future.value(Directory.systemTemp));

    await HiveBoxProvider.init(pathProvider: pathProvider);

    storage = HiveKeyValueStorage();
  });

  tearDown(() async {
    try {
      await Hive.deleteFromDisk();
    } catch (_) {}
  });

  group("initialization", () {
    test("with default box provider", () async {
      storage = HiveKeyValueStorage();
      await storage.put({"key": "value"}, "key");
    });

    test("with custom box provider", () async {
      final boxProvider = HiveBoxProvider(boxKey: "custom_box_key");
      storage = HiveKeyValueStorage(hiveBoxProvider: boxProvider);
      await storage.put({"key": "value"}, "key");
    });
  });

  group("operations", () {
    test("should save and retrieve data successfully", () async {
      final json = {"key": "value"};
      await storage.put(json, key);
      final storedJson = await storage.get(key);
      expect(json, equals(storedJson));
    });

    test("should handle error when retrieving non existing data", () async {
      expect(
          () async => await storage.get(key), throwsA(KeyValueStorageException.noValueFound(key)));
    });
  });
}
