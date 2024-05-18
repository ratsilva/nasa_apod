import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:nasa_picture_data/src/datasource/remote_data_source.dart';
import 'package:nasa_picture_data/src/dto/nasa_picture_dto.dart';
import 'package:network_service/network_service.dart';

import '../mocks/mocks.mocks.dart';

void main() {
  late NasaPictureDto dto;

  late Target target;
  late NetworkService networkService;
  late RemoteDataSource remoteDataSource;

  setUp(() {
    dto = NasaPictureDto(
      title: "title",
      explanation: "explanation",
      url: "url",
      dateTime: DateTime(2024, 1, 1),
    );

    target = NasaPictureTarget();
    networkService = MockNetworkService();
    remoteDataSource = RemoteDataSourceImpl(networkService);
  });

  test("getAll", () async {
    when(networkService.requestList(target, NasaPictureDto.fromJson)).thenAnswer((_) {
      return Future.value([dto]);
    });

    final result = await remoteDataSource.getAll();

    expect(result, [dto]);

    verify(networkService.requestList(target, NasaPictureDto.fromJson)).called(1);
  });
}
