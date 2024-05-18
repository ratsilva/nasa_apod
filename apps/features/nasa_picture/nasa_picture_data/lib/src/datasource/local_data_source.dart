import 'package:storage_service/storage_service.dart';

import '../dto/nasa_picture_dto.dart';

///
mixin LocalDataSource {
  Future<NasaPictureDto> getByDate(DateTime date);
  Future<List<NasaPictureDto>> upsertAll(List<NasaPictureDto> pictures);
}

///
class LocalDataSourceImpl with LocalDataSource {
  final StorageService _storageService;

  const LocalDataSourceImpl(this._storageService);

  @override
  Future<NasaPictureDto> getByDate(DateTime date) {
    return _storageService.get(date.toIso8601String(), NasaPictureDto.fromJson);
  }

  @override
  Future<List<NasaPictureDto>> upsertAll(List<NasaPictureDto> pictures) {
    pictures.forEach((pic) async {
      await _storageService.put(
          pic.toJson(), pic.dateTime.toIso8601String(), NasaPictureDto.fromJson);
    });
    return Future.value(pictures);
  }
}
