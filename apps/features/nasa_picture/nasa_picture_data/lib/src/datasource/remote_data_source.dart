import 'package:network_service/network_service.dart';
import 'package:network_service/src/target/http_method.dart';

import '../dto/nasa_picture_dto.dart';

///
mixin RemoteDataSource {
  Future<List<NasaPictureDto>> getAll();
}

///
class RemoteDataSourceImpl with RemoteDataSource {
  final NetworkService _networkService;

  const RemoteDataSourceImpl(this._networkService);

  @override
  Future<List<NasaPictureDto>> getAll() {
    final target = NasaPictureTarget();
    return _networkService.requestList(target, NasaPictureDto.fromJson);
  }
}

///
class NasaPictureTarget extends Target {
  @override
  HttpMethod get method => HttpMethod.get;

  @override
  String get path => "/apod";

  @override
  Map<String, dynamic>? get queryParameters => {
        "api_key": "FT9UYrLAH0V3NCg73f0AZjSg8US0ZL4uEHzQpgK3",
        "start_date": "2024-04-14",
        "end_date": "2024-05-16",
      };
}
