import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:storage_service/storage_service.dart';

import 'mocks/mocks.mocks.dart';

///
class _CustomException implements Exception {
  final String message;
  const _CustomException(this.message);
}

///
void main() {
  late String key;
  late String value;
  late Map<String, dynamic> json;

  late KeyValueStorage storage;
  late StorageService storageService;

  setUp(() {
    key = "key";
    value = "value";
    json = {key: value};

    storage = MockKeyValueStorage();
    storageService = StorageService(storage);
  });

  group("get method", () {
    setUp(() {
      when(storage.get(key)).thenAnswer((_) => Future.value(json));
    });

    test("should retrieve value when it exists", () async {
      final result = await storageService.get<String>(key, (json) => json[key]);

      expect(result, value);

      verify(storage.get(key)).called(1);
    });

    test("should handle error when it does not exist", () async {
      final exception = _CustomException("key does not exist");
      when(storage.get(key)).thenThrow(exception);

      expect(
        () => storageService.get(key, (json) => json[key]),
        throwsA(isA<_CustomException>()),
      );

      verify(storage.get(key)).called(1);
    });
  });

  group("filter method", () {
    setUp(() {
      when(storage.filter(key)).thenAnswer((_) => Future.value([json]));
    });

    test("should retrieve value when filter matches", () async {
      final result = await storageService.filter<String>(key, (json) => json[key]);

      expect(result, [value]);

      verify(storage.filter(key)).called(1);
    });
  });

  group("put method", () {
    setUp(() {
      when(storage.put(json, key)).thenAnswer((_) => Future.value(json));
    });

    test("should save data successfully", () async {
      final result = await storageService.put<String>(json, key, (json) => json[key]);

      expect(result, value);

      verify(storage.put(json, key)).called(1);
    });

    test("should handle error when put method fails", () async {
      final exception = _CustomException("key does not exist");
      when(storage.put(json, key)).thenThrow(exception);

      expect(
        () => storageService.put<String>(json, key, (json) => json[key]),
        throwsA(isA<_CustomException>()),
      );

      verify(storage.put(json, key)).called(1);
    });
  });
}
