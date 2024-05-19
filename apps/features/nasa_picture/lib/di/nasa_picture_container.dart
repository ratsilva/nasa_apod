import 'package:core_architecture/core_architecture.dart';
import 'package:nasa_picture_data/nasa_picture_data.dart';
import 'package:nasa_picture_domain/nasa_picture_domain.dart';
import 'package:nasa_picture_presentation/nasa_picture_presentation.dart';

class NasaPictureContainer {
  final GetIt _getIt;

  const NasaPictureContainer(this._getIt);

  T _get<T extends Object>() {
    return _getIt.get();
  }

  void register() {
    _getIt.registerFactory(
      () => LocalDataSourceImpl(_get()) as LocalDataSource,
    );

    _getIt.registerFactory(
      () => RemoteDataSourceImpl(_get()) as RemoteDataSource,
    );

    _getIt.registerLazySingleton(() => NasaPicturePaginationEngine(
          PaginationEngine(
            NasaPicturePaginationSource(_get(), _get()),
          ),
        ));

    _getIt.registerFactory(
      () => NasaPictureRepositoryImpl(_get(), _get()) as NasaPictureRepository,
    );

    _getIt.registerFactory(
      () => NasaPictureGetListUseCase(_get()),
    );

    _getIt.registerFactory(
      () => NasaPictureGetUseCase(_get()),
    );

    _getIt.registerFactory(
      () => NasaPictureDetailModule(_get()),
    );

    _getIt.registerFactory(
      () => NasaPictureListModule(
        _get(),
        _get(),
        SearchEngine<FilterableNasaPicture>(StartWithFilterMatcher()),
      ),
    );

    _getIt.registerSingleton(NasaPictureNavigation(_get(), _get()));
  }
}
