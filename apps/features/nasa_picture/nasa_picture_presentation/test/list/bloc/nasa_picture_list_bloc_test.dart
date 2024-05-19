import 'dart:async';

import 'package:core_architecture/core_architecture.dart';
import 'package:core_foundation/core_foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:nasa_picture_domain/nasa_picture_domain.dart';
import 'package:nasa_picture_presentation/src/list/bloc/nasa_picture_list_bloc.dart';
import 'package:nasa_picture_presentation/src/list/bloc/nasa_picture_list_event.dart';
import 'package:nasa_picture_presentation/src/list/bloc/nasa_picture_list_state.dart';

import '../../helper/bloc_test_helper.dart';
import '../../mocks/mocks.mocks.dart';

void main() {
  late NasaPicture picture;
  late NasaPictureGetListUseCase getListUseCase;
  late SearchEngine<FilterableNasaPicture> searchEngine;
  late StreamController<bool> controller;
  late NasaPictureListBloc bloc;

  setUp(() {
    picture = NasaPicture(
      title: "title",
      explanation: "explanation",
      url: "url",
      dateTime: DateTime(2024, 1, 1),
    );

    getListUseCase = MockNasaPictureGetListUseCase();
    searchEngine = MockSearchEngine();
    controller = MockStreamController();

    bloc = NasaPictureListBloc(getListUseCase, searchEngine, streamBuilder: () => controller);
  });

  test("initial state", () {
    final expectedStates = [NasaPictureListState()];
    expectBloc(bloc, emitsInOrder(expectedStates));
  });

  group("NasaPictureListStartEvent", () {
    test("on success", () {
      final result = Result<List<NasaPicture>, NasaPictureGetListException>.success([picture]);
      when(getListUseCase.call(controller)).thenAnswer((_) => Stream.value(result));

      final expectedStates = [
        NasaPictureListState(),
        NasaPictureListState(pictures: [picture]),
      ];

      expectBloc(bloc, emitsInOrder(expectedStates));
      bloc.add(NasaPictureListStartEvent());
    });

    test("on exception", () {
      final exception = NasaPictureGetListException.generic("error");
      final result = Result<List<NasaPicture>, NasaPictureGetListException>.exception(exception);
      when(getListUseCase.call(controller)).thenAnswer((_) => Stream.value(result));

      final expectedStates = [
        NasaPictureListState(),
        NasaPictureListState(error: true),
      ];

      expectBloc(bloc, emitsInOrder(expectedStates));
      bloc.add(NasaPictureListStartEvent());
    });
  });

  group("NasaPictureListSearchEvent", () {
    const String searchTerm = "title";

    test("on filtering", () {
      final result = Result<List<NasaPicture>, NasaPictureGetListException>.success([picture]);
      when(getListUseCase.call(controller)).thenAnswer((_) => Stream.value(result));

      when(searchEngine.matches(searchTerm, [picture.filterable])).thenReturn([picture.filterable]);

      final expectedStates = [
        NasaPictureListState(),
        NasaPictureListState(pictures: [picture]),
        NasaPictureListState(pictures: [picture], searchPictures: [picture]),
      ];

      expectBloc(bloc, emitsInOrder(expectedStates));
      bloc.add(NasaPictureListStartEvent());
      bloc.add(NasaPictureListSearchEvent(searchTerm));
    });
  });

  group("NasaPictureListNextPageEvent", () {
    test("on fetching next page", () async {
      final result = Result<List<NasaPicture>, NasaPictureGetListException>.success([picture]);
      when(getListUseCase.call(controller)).thenAnswer((_) => Stream.value(result));

      final expectedStates = [
        NasaPictureListState(),
        NasaPictureListState(pictures: [picture]),
      ];

      expectBloc(bloc, emitsInOrder(expectedStates));
      bloc.add(NasaPictureListStartEvent());
      bloc.add(NasaPictureListNextPageEvent());

      await Future.delayed(const Duration(milliseconds: 10));
      verify(controller.add(true)).called(2);
    });
  });
}
