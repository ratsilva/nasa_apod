import 'package:core_foundation/core_foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:nasa_picture_domain/nasa_picture_domain.dart';
import 'package:nasa_picture_presentation/src/detail/bloc/nasa_picture_detail_bloc.dart';
import 'package:nasa_picture_presentation/src/detail/bloc/nasa_picture_detail_event.dart';
import 'package:nasa_picture_presentation/src/detail/bloc/nasa_picture_detail_state.dart';

import '../../helper/bloc_test_helper.dart';
import '../../mocks/mocks.mocks.dart';

void main() {
  late NasaPicture picture;
  late NasaPictureGetUseCase getUseCase;
  late NasaPictureDetailBloc bloc;

  setUp(() {
    picture = NasaPicture(
      title: "title",
      explanation: "explanation",
      url: "url",
      dateTime: DateTime(2024, 1, 1),
    );

    getUseCase = MockNasaPictureGetUseCase();

    bloc = NasaPictureDetailBloc(getUseCase);
  });

  test("initial state", () {
    final expectedStates = [NasaPictureDetailState()];
    expectBloc(bloc, emitsInOrder(expectedStates));
  });

  group("NasaPictureDetailStartEvent", () {
    test("on success", () {
      final result = Result<NasaPicture, NasaPictureGetException>.success(picture);
      when(getUseCase.call(picture.dateTime)).thenAnswer((_) => Stream.value(result));

      final expectedStates = [
        NasaPictureDetailState(),
        NasaPictureDetailState(picture: picture),
      ];

      expectBloc(bloc, emitsInOrder(expectedStates));
      bloc.add(NasaPictureDetailStartEvent(picture.dateTime));
    });

    test("on exception", () {
      final exception = NasaPictureGetException.generic("error");
      final result = Result<NasaPicture, NasaPictureGetException>.exception(exception);
      when(getUseCase.call(picture.dateTime)).thenAnswer((_) => Stream.value(result));

      final expectedStates = [
        NasaPictureDetailState(),
        NasaPictureDetailState(error: true),
      ];

      expectBloc(bloc, emitsInOrder(expectedStates));
      bloc.add(NasaPictureDetailStartEvent(picture.dateTime));
    });
  });
}
