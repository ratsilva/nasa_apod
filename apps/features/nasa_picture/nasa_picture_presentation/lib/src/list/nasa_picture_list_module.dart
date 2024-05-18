import 'package:core_architecture/core_architecture.dart';
import 'package:nasa_picture_domain/nasa_picture_domain.dart';

import '../../nasa_picture_presentation.dart';
import 'nasa_picture_list_provider.dart';

class NasaPictureListModule with Module<EmptyParameters> {
  final NasaPictureDetailModule _detailModule;
  final NasaPictureGetListUseCase _getListUseCase;
  final SearchEngine<FilterableNasaPicture> _searchEngine;

  const NasaPictureListModule(this._detailModule, this._getListUseCase, this._searchEngine);

  @override
  String get route => "nasa_picture_list";

  @override
  NasaPictureListProvider build(EmptyParameters parameters) {
    return NasaPictureListProvider(
      detailModule: _detailModule,
      getListUseCase: _getListUseCase,
      searchEngine: _searchEngine,
    );
  }
}
