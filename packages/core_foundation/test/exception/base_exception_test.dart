import 'package:core_foundation/src/exception/base_exception.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

///
void main() {
  const error = "error";
  const exception = _TestException(error);

  test("toString", () {
    expect(
      exception.toString(),
      "[_TestException] origin: error",
    );
  });

  group("equality", () {
    test("object", () {
      expect(
        _TestException("error"),
        _TestException("error"),
      );
    });

    test("hashCode", () {
      expect(
        _TestException("error").hashCode,
        _TestException("error").hashCode,
      );
    });
  });
}

///
class _TestException extends BaseException {
  const _TestException([Object? e]) : super(e);
}
