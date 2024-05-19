import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:nasa_picture_data/src/datasource/local_data_source.dart';
import 'package:nasa_picture_data/src/datasource/pagination/nasa_picture_pagination_engine.dart';
import 'package:nasa_picture_data/src/dto/nasa_picture_dto.dart';
import 'package:nasa_picture_data/src/repository/nasa_picture_repository_impl.dart';
import 'package:nasa_picture_domain/nasa_picture_domain.dart';

import '../mocks/mocks.mocks.dart';

void main() {
  late StreamController<bool> nextPageTrigger;
  late DateTime dateTime;

  late LocalDataSource localDataSource;
  late NasaPicturePaginationEngine nasaPicturePaginationEngine;
  late NasaPictureRepositoryImpl repositoryImpl;

  setUp(() {
    nextPageTrigger = StreamController<bool>();
    dateTime = DateTime(2024, 1, 1);

    localDataSource = MockLocalDataSource();
    nasaPicturePaginationEngine = MockNasaPicturePaginationEngine();

    repositoryImpl = NasaPictureRepositoryImpl(localDataSource, nasaPicturePaginationEngine);
  });

  group("get method", () {
    test("should retrieve data successfully when localDataSource returns data", () async {
      /// arrange
      final dto = NasaPictureDto(
        title: "title",
        explanation: "explanation",
        url: "url",
        dateTime: dateTime,
      );

      when(localDataSource.getByDate(dateTime)).thenAnswer((_) => Future.value(dto));

      /// act
      final result = await repositoryImpl.get(dateTime).first;

      /// assert
      var expected = false;
      result.when(
        success: (data) {
          expect(data, dto.toEntity());
          expected = true;
        },
        exception: (e) {
          throw e;
        },
      );
      expect(expected, isTrue);
    });

    test("should failure when localDataSource return error", () async {
      /// arrange
      final exception = Exception("error");
      when(localDataSource.getByDate(dateTime)).thenAnswer((_) => Future.error(exception));

      /// act
      final result = await repositoryImpl.get(dateTime).first;

      /// assert
      var expected = false;
      result.when(
        success: (data) {
          throw "success should not be executed";
        },
        exception: (e) {
          expect(e, isA<NasaPictureGetException>());
          expected = true;
        },
      );
      expect(expected, isTrue);
    });
  });

  group("getList method", () {
    test("should retrieve data successfully when paginationEngine returns data", () async {
      /// arrange
      final dto = NasaPictureDto(
        title: "title",
        explanation: "explanation",
        url: "url",
        dateTime: dateTime,
      );

      when(nasaPicturePaginationEngine.pictures(nextPageTrigger: nextPageTrigger))
          .thenAnswer((_) => Stream.value([dto]));

      /// act
      final result = await repositoryImpl.getList(nextPageTrigger).first;

      /// assert
      var expected = false;
      result.when(
        success: (data) {
          expect(data, [dto.toEntity()]);
          expected = true;
        },
        exception: (e) {
          throw e;
        },
      );
      expect(expected, isTrue);
    });

    test("should failure when paginationEngine returns error", () async {
      /// arrange
      final exception = Exception("error");
      when(nasaPicturePaginationEngine.pictures(nextPageTrigger: nextPageTrigger))
          .thenAnswer((_) => Stream.error(exception));

      /// act
      final result = await repositoryImpl.getList(nextPageTrigger).first;

      /// assert
      var expected = false;
      result.when(
        success: (data) {
          throw "success should not be executed";
        },
        exception: (e) {
          expect(e, isA<NasaPictureGetListException>());
          expected = true;
        },
      );
      expect(expected, isTrue);
    });
  });
}
