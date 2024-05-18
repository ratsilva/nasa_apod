import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/mockito.dart';
import 'package:storage_service/src/storage/hive/path_provider.dart';
import 'package:storage_service/storage_service.dart';

import '../../mocks/mocks.mocks.dart';

void main() {
  late HiveBoxProvider provider;
  late PathProvider pathProvider;

  setUp(() async {
    const boxKey = "hive_key_value_storage_key";

    pathProvider = MockPathProvider();
    when(pathProvider.getDocumentsDirectory())
        .thenAnswer((_) => Future.value(Directory.systemTemp));

    await HiveBoxProvider.init(pathProvider: pathProvider);
    provider = HiveBoxProvider(boxKey: boxKey);
  });

  tearDown(() async {
    await Hive.deleteFromDisk();
  });

  group("returns hive box", () {
    test("when box is unitialized", () async {
      final box = await provider.getBox();
      expect(box.isOpen, isTrue);
    });

    test("when box is already initialized", () async {
      final box1 = await provider.getBox();
      final box2 = await provider.getBox();
      expect(box1.isOpen, isTrue);
      expect(box2.isOpen, isTrue);
      expect(box1, box2);
    });

    test("when home dir was deleted", () async {
      await provider.getBox();
      await Hive.deleteFromDisk();

      final box = await provider.getBox();
      expect(box.isOpen, isTrue);
    });
  });
}
