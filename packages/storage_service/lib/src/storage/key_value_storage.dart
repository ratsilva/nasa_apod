abstract class KeyValueStorage {
  /// Saves and return a json [value] using [key]
  Future<Map<String, dynamic>> put(Map<String, dynamic> value, String key);

  /// Retrieves a json value using [key]
  Future<Map<String, dynamic>> get(String key);

  /// Retrieves a list of json value which keys starts with [keyPrefix]
  Future<List<Map<String, dynamic>>> filter(String keyPrefix);
}
