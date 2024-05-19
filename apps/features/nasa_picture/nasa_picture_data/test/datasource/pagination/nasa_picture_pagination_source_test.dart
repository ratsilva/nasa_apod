import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:nasa_picture_data/src/datasource/local_data_source.dart';
import 'package:nasa_picture_data/src/datasource/pagination/nasa_picture_document.dart';
import 'package:nasa_picture_data/src/datasource/pagination/nasa_picture_pagination_source.dart';
import 'package:nasa_picture_data/src/datasource/remote_data_source.dart';
import 'package:nasa_picture_data/src/dto/nasa_picture_dto.dart';

import '../../mocks/mocks.mocks.dart';

void main() {
  late NasaPictureDto dto;
  late NasaPictureDto dto2;
  late NasaPictureDocumentParams params;
  late LocalDataSource localDataSource;
  late RemoteDataSource remoteDataSource;
  late NasaPicturePaginationSource paginationSource;

  setUp(() {
    dto = NasaPictureDto(
      title: "title",
      explanation: "explanation",
      url: "url",
      dateTime: DateTime(2024, 1, 1),
    );
    dto2 = NasaPictureDto(
      title: "title2",
      explanation: "explanation2",
      url: "url2",
      dateTime: DateTime(2024, 1, 2),
    );
    params = NasaPictureDocumentParams(DateTime(2024, 3, 1), DateTime(2024, 2, 1));

    localDataSource = MockLocalDataSource();
    remoteDataSource = MockRemoteDataSource();
    paginationSource = NasaPicturePaginationSource(localDataSource, remoteDataSource);
  });

  group("when fetching pages", () {
    test("should retrieve data successfully when remoteDataSource and localDataSource returns data",
        () async {
      /// arrange
      when(localDataSource.getAll()).thenAnswer((_) => Future.value([dto]));
      when(remoteDataSource.getAll(
        startDate: DateTime(2024, 2, 1).subtract(Duration(days: 15)),
        endDate: DateTime(2024, 2, 1),
      )).thenAnswer((_) => Future.value([dto2]));
      when(localDataSource.upsertAll([dto2])).thenAnswer((_) => Future.value([dto2]));

      /// act
      final result = paginationSource.docPageFrom(null, 15, params);

      /// assert
      expect(
        result,
        emitsInOrder([
          {NasaPicturePageDocument(dto)},
          {NasaPicturePageDocument(dto2)}
        ]),
      );
    });

    test(
        "should retrieve data successfully when localDataSource fails and remoteDataSource returns data",
        () async {
      /// arrange
      final exception = Exception("error");
      when(localDataSource.getAll()).thenAnswer((_) => Future.error(exception));
      when(remoteDataSource.getAll(
        startDate: DateTime(2024, 2, 1).subtract(Duration(days: 15)),
        endDate: DateTime(2024, 2, 1),
      )).thenAnswer((_) => Future.value([dto2]));
      when(localDataSource.upsertAll([dto2])).thenAnswer((_) => Future.value([dto2]));

      /// act
      final result = paginationSource.docPageFrom(null, 15, params);

      /// assert
      expect(
        result,
        emitsInOrder([
          {NasaPicturePageDocument(dto2)}
        ]),
      );
    });

    test(
        "should retrieve data successfully when localDataSource return data and remoteDataSource fails",
        () async {
      /// arrange
      final exception = Exception("error");
      when(localDataSource.getAll()).thenAnswer((_) => Future.value([dto]));
      when(remoteDataSource.getAll(
        startDate: DateTime(2024, 2, 1).subtract(Duration(days: 15)),
        endDate: DateTime(2024, 2, 1),
      )).thenAnswer((_) => Future.error(exception));

      /// act
      final result = paginationSource.docPageFrom(null, 15, params);

      /// assert
      expect(
        result,
        emitsInOrder([
          {NasaPicturePageDocument(dto)}
        ]),
      );
    });

    test(
        "should retrieve data successfully when localDataSource return data and remoteDataSource return empty",
        () async {
      /// arrange
      when(localDataSource.getAll()).thenAnswer((_) => Future.value([dto]));
      when(remoteDataSource.getAll(
        startDate: DateTime(2024, 2, 1).subtract(Duration(days: 15)),
        endDate: DateTime(2024, 2, 1),
      )).thenAnswer((_) => Future.value([]));

      /// act
      final result = paginationSource.docPageFrom(null, 15, params);

      /// assert
      expect(
        result,
        emitsInOrder([
          {NasaPicturePageDocument(dto)}
        ]),
      );
    });

    test("should failure when localDataSource and remoteDataSource fails", () async {
      /// arrange
      final exception = Exception("error");
      when(localDataSource.getAll()).thenAnswer((_) => Future.error(exception));
      when(remoteDataSource.getAll(
        startDate: DateTime(2024, 2, 1).subtract(Duration(days: 15)),
        endDate: DateTime(2024, 2, 1),
      )).thenAnswer((_) => Future.error(exception));

      /// act
      final result = paginationSource.docPageFrom(null, 15, params);

      /// assert
      expect(
        result,
        emitsError(exception),
      );
    });
  });
}
