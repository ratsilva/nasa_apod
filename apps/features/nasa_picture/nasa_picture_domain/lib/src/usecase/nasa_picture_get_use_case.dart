import 'package:core_architecture/core_architecture.dart';
import 'package:core_foundation/core_foundation.dart';

import '../entity/nasa_picture.dart';
import '../repository/nasa_picture_repository.dart';

class NasaPictureGetUseCase with UseCase<DateTime, NasaPicture> {
  final NasaPictureRepository _nasaPictureRepository;

  const NasaPictureGetUseCase(this._nasaPictureRepository);

  @override
  Stream<Result<NasaPicture, NasaPictureGetException>> call(DateTime date) {
    return _nasaPictureRepository.get(date);
  }
}
