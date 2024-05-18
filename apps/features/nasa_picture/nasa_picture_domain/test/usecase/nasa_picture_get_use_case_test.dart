import 'package:core_foundation/core_foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:nasa_picture_domain/src/entity/nasa_picture.dart';
import 'package:nasa_picture_domain/src/repository/nasa_picture_repository.dart';
import 'package:nasa_picture_domain/src/usecase/nasa_picture_get_use_case.dart';

import '../mocks/mocks.mocks.dart';

void main() {
  late DateTime dateTime;

  late NasaPictureRepository repository;
  late NasaPictureGetUseCase useCase;

  setUp(() {
    dateTime = DateTime(2024, 1, 1);

    repository = MockNasaPictureRepository();
    useCase = NasaPictureGetUseCase(repository);
  });

  test("on success", () async {
    /// arrange
    final picture = NasaPicture(
      title: "title",
      explanation: "explanation",
      url: "url",
      dateTime: dateTime,
    );
    final mockResponse = Result<NasaPicture, NasaPictureGetException>.success(picture);

    when(repository.get(dateTime)).thenAnswer((_) => Stream.value(mockResponse));

    /// act
    final result = await useCase(dateTime).first;

    /// assert
    var expected = false;
    result.when(
      success: (data) {
        expect(data, picture);
        expected = true;
      },
      exception: (e) {
        throw e;
      },
    );
    expect(expected, isTrue);
  });

  test("on error", () async {
    /// arrange
    final exception = NasaPictureGetException.generic("error");
    final mockResponse = Result<NasaPicture, NasaPictureGetException>.exception(exception);

    when(repository.get(dateTime)).thenAnswer((_) => Stream.value(mockResponse));

    /// act
    final result = await useCase(dateTime).first;

    /// assert
    var expected = false;
    result.when(
      success: (data) {
        throw "success should not be executed";
      },
      exception: (e) {
        expect(e, exception);
        expected = true;
      },
    );
    expect(expected, isTrue);
  });
}
