import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:nasa_picture_data/src/datasource/local_data_source.dart';
import 'package:nasa_picture_data/src/dto/nasa_picture_dto.dart';
import 'package:storage_service/storage_service.dart';

import '../mocks/mocks.mocks.dart';

void main() {
  late NasaPictureDto dto;

  late StorageService storageService;
  late LocalDataSource localDataSource;

  setUp(() {
    dto = NasaPictureDto(
      title: "title",
      explanation: "explanation",
      url: "url",
      dateTime: DateTime(2024, 1, 1),
    );

    storageService = MockStorageService();
    localDataSource = LocalDataSourceImpl(storageService);
  });

  test("getByDate", () async {
    when(storageService.get(dto.dateTime.toIso8601String(), NasaPictureDto.fromJson))
        .thenAnswer((_) => Future.value(dto));

    final result = await localDataSource.getByDate(dto.dateTime);

    expect(result, dto);

    verify(storageService.get(dto.dateTime.toIso8601String(), NasaPictureDto.fromJson)).called(1);
  });

  test("upsertAll", () async {
    when(storageService.put(dto.toJson(), dto.dateTime.toIso8601String(), NasaPictureDto.fromJson))
        .thenAnswer((_) => Future.value(dto));

    final result = await localDataSource.upsertAll([dto]);

    expect(result, [dto]);

    verify(storageService.put(
            dto.toJson(), dto.dateTime.toIso8601String(), NasaPictureDto.fromJson))
        .called(1);
  });
}
