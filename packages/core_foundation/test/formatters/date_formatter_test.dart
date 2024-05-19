import 'package:core_foundation/src/formatters/date_formatter.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  final formatter = DateFormatter();

  test("formats now to dd/MM/yyyy", () {
    final now = DateTime(2024, 2, 1);
    expect(formatter.formatddMMyyyy(now), "01/02/2024");
  });

  test("formats now to yyyy-MM-ddd", () {
    final now = DateTime(2024, 2, 1);
    expect(formatter.formatyyyyMMdd(now), "2024-02-01");
  });
}
