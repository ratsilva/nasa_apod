import 'package:core_foundation/core_foundation.dart';
import 'package:nasa_picture_domain/nasa_picture_domain.dart';

import '../datasource/local_data_source.dart';
import '../datasource/remote_data_source.dart';

class NasaPictureRepositoryImpl with NasaPictureRepository {
  final LocalDataSource _localDataSource;
  final RemoteDataSource _remoteDataSource;

  const NasaPictureRepositoryImpl(this._localDataSource, this._remoteDataSource);

  @override
  Stream<Result<NasaPicture, NasaPictureGetException>> get(DateTime date) {
    return _localDataSource
        .getByDate(date)
        .asStream()
        .map((picture) => picture.toEntity())
        .foldResult<NasaPictureGetException>((e, _) => NasaPictureGetException.generic(e));
  }

  @override
  Stream<Result<List<NasaPicture>, NasaPictureGetListException>> getList() {
    return _remoteDataSource
        .getAll()
        .then((dataFromRemote) =>
            _localDataSource.upsertAll(dataFromRemote).catchError((e) => dataFromRemote))
        .asStream()
        .map((dtos) => dtos.map((dto) => dto.toEntity()).toList())
        .foldResult<NasaPictureGetListException>((e, _) => NasaPictureGetListException.generic(e));
  }
}
