import 'storage/key_value_storage.dart';

class StorageService {
  /// Implementation of key value storage
  final KeyValueStorage _storage;

  const StorageService(this._storage);

  /// Gets a value [Model] associated with provided [key].
  ///
  /// This method will throw a [KeyValueStorageException] error if no value is found in key value
  /// storage.
  Future<Model> get<Model>(
    String key,
    Model Function(Map<String, dynamic>) deserializer,
  ) async {
    final json = await _storage.get(key);
    return deserializer(json);
  }

  /// Saves a value [Model] associating with provided [key].
  ///
  /// Saving a model that has already being saved will replace it's contents in the key value
  /// storage.
  Future<Model> put<Model>(
    Map<String, dynamic> json,
    String key,
    Model Function(Map<String, dynamic>) deserializer,
  ) async {
    await _storage.put(json, key);
    return Future.value(deserializer(json));
  }
}
