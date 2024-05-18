import 'package:core_architecture/core_architecture.dart';
import 'package:nasa_picture_domain/nasa_picture_domain.dart';

import 'nasa_picture_list_provider.dart';

class NasaPictureListModule with Module<EmptyParameters> {
  final NasaPictureGetListUseCase _getListUseCase;

  const NasaPictureListModule(this._getListUseCase);

  @override
  String get route => "nasa_picture_list";

  @override
  NasaPictureListProvider build(EmptyParameters parameters) {
    return NasaPictureListProvider(
      getListUseCase: _getListUseCase,
    );
  }
}
