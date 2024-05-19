import 'dart:async';

import 'package:core_architecture/core_architecture.dart';
import 'package:core_foundation/core_foundation.dart';

import '../entity/nasa_picture.dart';
import '../repository/nasa_picture_repository.dart';

class NasaPictureGetListUseCase with UseCase<StreamController<bool>, List<NasaPicture>> {
  final NasaPictureRepository _nasaPictureRepository;

  const NasaPictureGetListUseCase(this._nasaPictureRepository);

  @override
  Stream<Result<List<NasaPicture>, NasaPictureGetListException>> call(
    StreamController<bool> params,
  ) {
    return _nasaPictureRepository.getList(params);
  }
}
