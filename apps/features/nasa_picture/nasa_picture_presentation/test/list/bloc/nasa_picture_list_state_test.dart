import 'package:flutter_test/flutter_test.dart';
import 'package:nasa_picture_domain/nasa_picture_domain.dart';
import 'package:nasa_picture_presentation/src/list/bloc/nasa_picture_list_state.dart';

void main() {
  late NasaPicture picture;
  late NasaPictureListState state;

  setUp(() {
    picture = NasaPicture(
      title: "title",
      explanation: "explanation",
      url: "url",
      isValidImage: true,
      dateTime: DateTime(2024, 1, 1),
    );

    state = NasaPictureListState();
  });

  test("initial state", () {
    expect(state.pictures, isNull);
    expect(state.searchPictures, isNull);
    expect(state.error, isFalse);
  });

  group("properties", () {
    group("loading", () {
      test("return false when pictures is not null", () {
        final state = NasaPictureListState(pictures: [picture]);
        expect(state.loading, isFalse);
      });

      test("return false when error is true", () {
        const state = NasaPictureListState(error: true);
        expect(state.loading, isFalse);
      });

      test("return true when pictures is null and error is false", () {
        const state = NasaPictureListState();
        expect(state.loading, isTrue);
      });
    });

    group("picturesList", () {
      test("when there is searchPictures", () {
        final state = NasaPictureListState(searchPictures: [picture]);
        expect(state.picturesList, [picture]);
      });

      test("return there is no searchPictures but pictures", () {
        final state = NasaPictureListState(pictures: [picture]);
        expect(state.picturesList, [picture]);
      });

      test("return there is neither searchPictures and searchPictures", () {
        const state = NasaPictureListState();
        expect(state.picturesList, []);
      });
    });
  });

  group("methods", () {
    group("copy", () {
      test("with pictures", () async {
        final pictures = [picture];
        final copiedState = state.copy(pictures: pictures);

        expect(state.pictures, isNull);
        expect(copiedState.pictures, pictures);
      });

      test("with searchPictures", () async {
        final pictures = [picture];
        final copiedState = state.copy(searchPictures: pictures);

        expect(state.searchPictures, isNull);
        expect(copiedState.searchPictures, pictures);
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
