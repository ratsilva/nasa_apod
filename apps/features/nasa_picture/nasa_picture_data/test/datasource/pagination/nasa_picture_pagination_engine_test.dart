import 'dart:async';

import 'package:core_architecture/core_architecture.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:nasa_picture_data/src/datasource/pagination/nasa_picture_document.dart';
import 'package:nasa_picture_data/src/datasource/pagination/nasa_picture_pagination_engine.dart';
import 'package:nasa_picture_data/src/datasource/pagination/nasa_picture_pagination_source.dart';
import 'package:nasa_picture_data/src/dto/nasa_picture_dto.dart';

import '../../mocks/mocks.mocks.dart';

void main() {
  late NasaPictureDto dto;
  late NasaPicturePageDocument document;
  late StreamController<bool> nextPageTrigger;

  late PaginationEngine<NasaPicturePageDocument, NasaPictureDocumentParams> paginationEngine;
  late NasaPicturePaginationEngine engine;

  setUp(() {
    OverridableDateTime.overrideDateTime = DateTime(2021, 1, 1);

    dto = NasaPictureDto(
      title: "title",
      explanation: "explanation",
      url: "url",
      mediaType: "image",
      dateTime: DateTime(2024, 1, 1),
    );
    document = NasaPicturePageDocument(dto);
    nextPageTrigger = StreamController<bool>();

    paginationEngine = MockPaginationEngine<NasaPicturePageDocument, NasaPictureDocumentParams>();
    engine = NasaPicturePaginationEngine(paginationEngine);
  });

  test("shoud fetch data from pagination engine", () async {
    /// arrange
    final endDate = OverridableDateTime.now;
    final startDate = endDate.subtract(Duration(days: 15));
    when(paginationEngine.documents(
      nextPageTrigger.stream,
      15,
      NasaPictureDocumentParams(startDate, endDate),
    )).thenAnswer(
      (_) => Stream.value({document}),
    );

    /// act
    final result = await engine.pictures(nextPageTrigger: nextPageTrigger).first;

    /// assert
    expect(result, [dto]);
  });
}
