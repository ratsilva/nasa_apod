import 'package:core_foundation/src/exception/base_exception.dart';
import 'package:core_foundation/src/extensions/stream_extensions.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

///
void main() {
  const error = "error";

  group("fold result", () {
    test("to success result", () async {
      bool expected = false;
      final result = await Stream.value("data").foldResult((e, __) => _TestException(e)).first;

      result.when(
        success: (data) {
          expect(data, "data");
          expected = true;
        },
        exception: (e) {
          throw e;
        },
      );

      expect(expected, true);
    });

    test("to exception result", () async {
      bool expected = false;
      final result = await Stream.error(error).foldResult((e, __) => _TestException(e)).first;

      result.when(
        success: (data) {
          throw "success should not be executed";
        },
        exception: (e) {
          expect(e, isA<_TestException>());
          expected = true;
        },
      );

      expect(expected, true);
    });
  });
}

///
class _TestException extends BaseException {
  const _TestException([Object? e]) : super(e);
}
