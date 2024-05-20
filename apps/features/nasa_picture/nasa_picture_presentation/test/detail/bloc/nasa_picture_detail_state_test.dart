import 'package:flutter_test/flutter_test.dart';
import 'package:nasa_picture_domain/nasa_picture_domain.dart';
import 'package:nasa_picture_presentation/src/detail/bloc/nasa_picture_detail_state.dart';

void main() {
  late NasaPicture picture;
  late NasaPictureDetailState state;

  setUp(() {
    picture = NasaPicture(
      title: "title",
      explanation: "explanation",
      url: "url",
      isValidImage: true,
      dateTime: DateTime(2024, 1, 1),
    );

    state = NasaPictureDetailState();
  });

  test("initial state", () {
    expect(state.picture, isNull);
    expect(state.error, isFalse);
  });

  group("properties", () {
    group("loading", () {
      test("return false when picture is not null", () {
        final state = NasaPictureDetailState(picture: picture);
        expect(state.loading, isFalse);
      });

      test("return false when error is true", () {
        const state = NasaPictureDetailState(error: true);
        expect(state.loading, isFalse);
      });

      test("return true when picture is null and error is false", () {
        const state = NasaPictureDetailState();
        expect(state.loading, isTrue);
      });
    });
  });

  group("methods", () {
    group("copy", () {
      test("with picture", () async {
        final copiedState = state.copy(picture: picture);

        expect(state.picture, isNull);
        expect(copiedState.picture, picture);
      });

      test("with error", () {
        const error = true;
        final copiedState = state.copy(error: error);

        expect(state.error, isFalse);
        expect(copiedState.error, error);
      });
    });
  });
}
