import 'package:core_architecture/core_architecture.dart';
import 'package:nasa_picture_domain/nasa_picture_domain.dart';

import 'nasa_picture_detail_provider.dart';

class NasaPictureDetailModuleParameters {
  final DateTime dateTime;

  const NasaPictureDetailModuleParameters({
    required this.dateTime,
  });
}

class NasaPictureDetailModule with Module<NasaPictureDetailModuleParameters> {
  final NasaPictureGetUseCase _getUseCase;

  const NasaPictureDetailModule(this._getUseCase);

  @override
  String get route => "nasa_picture_detail";

  @override
  NasaPictureDetailProvider build(NasaPictureDetailModuleParameters parameters) {
    return NasaPictureDetailProvider(
      getUseCase: _getUseCase,
      dateTime: parameters.dateTime,
    );
  }
}
