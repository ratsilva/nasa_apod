import 'package:core_foundation/core_foundation.dart';
import 'package:nasa_picture_domain/nasa_picture_domain.dart';

import '../datasource/local_data_source.dart';
import '../datasource/remote_data_source.dart';
import '../dto/nasa_picture_dto.dart';

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
    bool isEmptyStorage = false;

    final dataFromLocal = () => _localDataSource.getAll().asStream().doOnError((_, __) {
          isEmptyStorage = true;
        }).onErrorResume((_, __) {
          return const Stream.empty();
        });

    final dataFromRemote = () {
      return _remoteDataSource
          .getAll()
          .asStream()
          .switchMap((data) => _localDataSource.upsertAll(data).asStream().onErrorReturn(data))
          .onErrorResume((e, s) {
        return isEmptyStorage
            ? Stream<List<NasaPictureDto>>.error(e, s)
            : Stream<List<NasaPictureDto>>.empty();
      });
    };

    return ConcatStream([dataFromLocal(), dataFromRemote()])
        .distinct()
        .map((dtos) => dtos.map((dto) => dto.toEntity()).toList())
        .foldResult<NasaPictureGetListException>((e, _) => NasaPictureGetListException.generic(e));
  }
}
