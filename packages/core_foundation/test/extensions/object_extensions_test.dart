import 'package:core_foundation/src/extensions/object_extensions.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  final int? optionalInt = 1;
  const int nonOptionalInt = 1;

  group("let", () {
    test("allows computation to transform value", () {
      expect(optionalInt?.let((value) => value.toString()), "1");
    });

    test("returns optional if computation is optional", () {
      expect(nonOptionalInt.let((_) => null), isA<int?>());
    });

    test("returns non optional if value and computation are non optional", () {
      expect(nonOptionalInt.let((value) => value * 10), isA<int>());
    });
  });
}
