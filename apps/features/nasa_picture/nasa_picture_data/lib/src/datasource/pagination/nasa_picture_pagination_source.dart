import 'package:core_architecture/core_architecture.dart';
import 'package:core_foundation/core_foundation.dart';

import '../../dto/nasa_picture_dto.dart';
import '../local_data_source.dart';
import '../remote_data_source.dart';
import 'nasa_picture_document.dart';

///
class NasaPicturePaginationSource
    implements PaginationSource<NasaPicturePageDocument, NasaPictureDocumentParams> {
  final LocalDataSource _localDataSource;
  final RemoteDataSource _remoteDataSource;

  const NasaPicturePaginationSource(this._localDataSource, this._remoteDataSource);

  @override
  Stream<Set<NasaPicturePageDocument>> docPageFrom(
    NasaPicturePageDocument? document,
    int size,
    NasaPictureDocumentParams params,
  ) {
    bool isEmptyStorage = false;

    final dataFromLocal = () => _localDataSource.getAll().asStream().doOnError((_, __) {
          isEmptyStorage = true;
        }).onErrorResume((_, __) {
          return const Stream.empty();
        });

    final endDate = document?.content.dateTime.subtract(Duration(days: 1)) ?? params.endDate;
    final startDate = endDate.subtract(Duration(days: size));

    final sort = (NasaPictureDto a, NasaPictureDto b) {
      return b.dateTime.compareTo(a.dateTime);
    };

    final dataFromRemote = () {
      return _remoteDataSource
          .getAll(startDate: startDate, endDate: endDate)
          .asStream()
          .switchMap((data) => _localDataSource.upsertAll(data).asStream().onErrorReturn(data))
          .onErrorResume((e, s) {
        return isEmptyStorage
            ? Stream<List<NasaPictureDto>>.error(e, s)
            : Stream<List<NasaPictureDto>>.empty();
      });
    };

    return ConcatStream([
      dataFromLocal(),
      dataFromRemote(),
    ])
        .distinct()
        .map((list) => (list..sort(sort)))
        .map((pictures) => pictures.map((pic) => NasaPicturePageDocument(pic)).toSet());
  }
}

///
class NasaPictureDocumentParams {
  final DateTime startDate;
  final DateTime endDate;
  NasaPictureDocumentParams(this.startDate, this.endDate);

  @override
  int get hashCode => startDate.hashCode ^ endDate.hashCode ^ 31;

  @override
  bool operator ==(Object other) {
    return other is NasaPictureDocumentParams &&
        other.startDate == startDate &&
        other.endDate == endDate;
  }
}
