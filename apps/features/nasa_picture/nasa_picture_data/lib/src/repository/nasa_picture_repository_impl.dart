import 'dart:async';

import 'package:core_foundation/core_foundation.dart';
import 'package:nasa_picture_domain/nasa_picture_domain.dart';

import '../datasource/local_data_source.dart';
import '../datasource/pagination/nasa_picture_pagination_engine.dart';

class NasaPictureRepositoryImpl with NasaPictureRepository {
  final LocalDataSource _localDataSource;
  final NasaPicturePaginationEngine _paginationEngine;

  const NasaPictureRepositoryImpl(this._localDataSource, this._paginationEngine);

  @override
  Stream<Result<NasaPicture, NasaPictureGetException>> get(DateTime date) {
    return _localDataSource
        .getByDate(date)
        .asStream()
        .map((picture) => picture.toEntity())
        .foldResult<NasaPictureGetException>((e, _) => NasaPictureGetException.generic(e));
  }

  @override
  Stream<Result<List<NasaPicture>, NasaPictureGetListException>> getList(
    StreamController<bool> nextPageTrigger,
  ) {
    return _paginationEngine
        .pictures(nextPageTrigger: nextPageTrigger)
        .map((dtos) => dtos.map((dto) => dto.toEntity()).toList())
        .foldResult<NasaPictureGetListException>((e, _) => NasaPictureGetListException.generic(e));
  }
}
