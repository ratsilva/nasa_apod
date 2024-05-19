import 'package:core_foundation/src/formatters/date_formatter.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  final formatter = DateFormatter();

  test("formats now to dd/MM", () {
    final now = DateTime(2024, 1, 1);
    expect(formatter.formatddMMyyyy(now), "01/01/2024");
  });
}
