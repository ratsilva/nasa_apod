import 'dart:async';

import 'package:core_foundation/core_foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../entity/nasa_picture.dart';

part 'nasa_picture_repository.freezed.dart';

///
mixin NasaPictureRepository {
  Stream<Result<NasaPicture, NasaPictureGetException>> get(DateTime date);

  Stream<Result<List<NasaPicture>, NasaPictureGetListException>> getList(
    StreamController<bool> nextPageTrigger,
  );
}

///
@freezed
class NasaPictureGetException extends BaseException with _$NasaPictureGetException {
  const factory NasaPictureGetException.generic([Object? origin]) = NasaPictureGetExceptionGeneric;
}

///
@freezed
class NasaPictureGetListException extends BaseException with _$NasaPictureGetListException {
  const factory NasaPictureGetListException.generic([Object? origin]) =
      NasaPictureGetListExceptionGeneric;
}
