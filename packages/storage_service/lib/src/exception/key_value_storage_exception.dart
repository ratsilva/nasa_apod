class KeyValueStorageException implements Exception {
  final String message;

  const KeyValueStorageException._({required this.message});

  static KeyValueStorageException noValueFound(String key) {
    return KeyValueStorageException._(
      message: "No value found for key: $key",
    );
  }

  @override
  operator ==(Object o) {
    return o is KeyValueStorageException && o.message == this.message;
  }

  @override
  int get hashCode {
    return this.message.hashCode ^ 31;
  }

  @override
  String toString() => 'KeyValueStorageException(message: $message)';
}
