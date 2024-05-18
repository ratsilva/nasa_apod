import 'package:core_architecture/core_architecture.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nasa_picture_domain/src/entity/nasa_picture.dart';

void main() {
  final picture = NasaPicture(
    title: "title",
    explanation: "explanation",
    url: "url",
    dateTime: DateTime(2024, 1, 1),
  );

  test("when filter by title matches", () {
    final result = picture.filterable.filter("title", StartWithFilterMatcher());

    expect(result, picture.filterable);
  });

  test("when filter by date matches", () {
    final result = picture.filterable.filter("2024-01-01", StartWithFilterMatcher());

    expect(result, picture.filterable);
  });

  test("when filter does not match", () {
    final result = picture.filterable.filter("test", StartWithFilterMatcher());

    expect(result, isNull);
  });
}
