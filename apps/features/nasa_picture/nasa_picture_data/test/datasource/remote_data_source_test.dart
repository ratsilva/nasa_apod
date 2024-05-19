import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:nasa_picture_data/src/datasource/remote_data_source.dart';
import 'package:nasa_picture_data/src/dto/nasa_picture_dto.dart';
import 'package:network_service/network_service.dart';
import 'package:network_service/src/target/http_method.dart';

import '../mocks/mocks.mocks.dart';

void main() {
  late DateTime startDate;
  late DateTime endDate;
  late NasaPictureDto dto;

  late Target target;
  late NetworkService networkService;
  late RemoteDataSource remoteDataSource;

  setUp(() {
    startDate = DateTime(2024, 3, 1);
    endDate = DateTime(2024, 2, 1);
    dto = NasaPictureDto(
      title: "title",
      explanation: "explanation",
      url: "url",
      dateTime: DateTime(2024, 1, 1),
    );

    target = NasaPictureTarget(startDate, endDate);
    networkService = MockNetworkService();
    remoteDataSource = RemoteDataSourceImpl(networkService);
  });

  group("target", () {
    test("build successfully", () {
      expect(target.method, HttpMethod.get);
      expect(target.path, "/apod");
      expect(target.queryParameters, {"start_date": "2024-03-01", "end_date": "2024-02-01"});
    });
  });

  test("getAll", () async {
    when(networkService.requestList(target, NasaPictureDto.fromJson)).thenAnswer((_) {
      return Future.value([dto]);
    });

    final result = await remoteDataSource.getAll(startDate: startDate, endDate: endDate);

    expect(result, [dto]);

    verify(networkService.requestList(target, NasaPictureDto.fromJson)).called(1);
  });
}
