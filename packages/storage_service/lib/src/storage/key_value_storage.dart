abstract class KeyValueStorage {
  /// Saves and return a json [value] using [key]
  Future<Map<String, dynamic>> put(Map<String, dynamic> value, String key);

  /// Retrieves a json value using [key]
  Future<Map<String, dynamic>> get(String key);
}
