import 'package:core_foundation/src/exception/base_exception.dart';
import 'package:core_foundation/src/types/result.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  const data = 1;
  const exception = BaseException("Fail");

  group("result creation", () {
    test("success factory", () {
      bool expected = false;
      const result = Result.success(data);

      result.when(
        success: (value) {
          expect(value, data);
          expected = true;
        },
        exception: (e) {
          throw e;
        },
      );

      expect(expected, true);
    });

    test("exception factory", () {
      bool expected = false;
      const result = Result.exception(exception);

      result.when(
        success: (_) {
          throw "success should not be executed";
        },
        exception: (e) {
          expect(e, exception);
          expected = true;
        },
      );

      expect(expected, true);
    });
  });
}
