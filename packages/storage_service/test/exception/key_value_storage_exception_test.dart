import 'package:flutter_test/flutter_test.dart';
import 'package:storage_service/src/exception/key_value_storage_exception.dart';

void main() {
  late KeyValueStorageException exception;

  setUp(() {
    exception = KeyValueStorageException.noValueFound("key");
  });

  test("toString", () {
    expect(
      exception.toString(),
      "KeyValueStorageException(message: No value found for key: key)",
    );
  });

  group("equality", () {
    test("object", () {
      expect(
        KeyValueStorageException.noValueFound("key"),
        KeyValueStorageException.noValueFound("key"),
      );
    });

    test("hashCode", () {
      expect(
        KeyValueStorageException.noValueFound("key").hashCode,
        KeyValueStorageException.noValueFound("key").hashCode,
      );
    });
  });
}
