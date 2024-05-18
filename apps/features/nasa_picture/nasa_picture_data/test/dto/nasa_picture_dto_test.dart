import 'package:flutter_test/flutter_test.dart';
import 'package:nasa_picture_data/src/dto/nasa_picture_dto.dart';
import 'package:nasa_picture_domain/nasa_picture_domain.dart';

void main() {
  late NasaPictureDto dto;

  setUp(() {
    dto = NasaPictureDto(
      title: "title",
      explanation: "explanation",
      url: "url",
      dateTime: DateTime(2024, 1, 1),
    );
  });

  test("toEntity", () {
    final entity = dto.toEntity();

    expect(
      entity,
      NasaPicture(
        title: "title",
        explanation: "explanation",
        url: "url",
        dateTime: DateTime(2024, 1, 1),
      ),
    );
  });
}
