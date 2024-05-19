import 'package:core_foundation/core_foundation.dart';
import 'package:network_service/network_service.dart';
import 'package:network_service/src/target/http_method.dart';

import '../dto/nasa_picture_dto.dart';

///
mixin RemoteDataSource {
  Future<List<NasaPictureDto>> getAll({
    required DateTime startDate,
    required DateTime endDate,
  });
}

///
class RemoteDataSourceImpl with RemoteDataSource {
  final NetworkService _networkService;

  const RemoteDataSourceImpl(this._networkService);

  @override
  Future<List<NasaPictureDto>> getAll({
    required DateTime startDate,
    required DateTime endDate,
  }) {
    final target = NasaPictureTarget(startDate, endDate);
    return _networkService.requestList(target, NasaPictureDto.fromJson);
  }
}

///
class NasaPictureTarget extends Target {
  final DateTime startDate;
  final DateTime endDate;

  NasaPictureTarget(this.startDate, this.endDate);

  @override
  HttpMethod get method => HttpMethod.get;

  @override
  String get path => "/apod";

  @override
  Map<String, dynamic>? get queryParameters => {
        "start_date": DateFormatter().formatyyyyMMdd(startDate),
        "end_date": DateFormatter().formatyyyyMMdd(endDate),
      };
}
