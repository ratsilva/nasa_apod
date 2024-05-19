import 'package:storage_service/storage_service.dart';

import '../dto/nasa_picture_dto.dart';

const String _kKeyPrefix = "NasaPictureDto";

///
mixin LocalDataSource {
  Future<NasaPictureDto> getByDate(DateTime date);
  Future<List<NasaPictureDto>> getAll();
  Future<List<NasaPictureDto>> upsertAll(List<NasaPictureDto> pictures);
  String buildKey(DateTime date) => "${_kKeyPrefix}_${date.toIso8601String()}";
}

///
class LocalDataSourceImpl with LocalDataSource {
  final StorageService _storageService;

  const LocalDataSourceImpl(this._storageService);

  @override
  Future<NasaPictureDto> getByDate(DateTime date) {
    return _storageService.get(buildKey(date), NasaPictureDto.fromJson);
  }

  @override
  Future<List<NasaPictureDto>> upsertAll(List<NasaPictureDto> pictures) {
    pictures.forEach((pic) async {
      await _storageService.put(pic.toJson(), buildKey(pic.dateTime), NasaPictureDto.fromJson);
    });
    return Future.value(pictures);
  }

  @override
  Future<List<NasaPictureDto>> getAll() {
    return _storageService.filter(_kKeyPrefix, NasaPictureDto.fromJson);
  }
}
