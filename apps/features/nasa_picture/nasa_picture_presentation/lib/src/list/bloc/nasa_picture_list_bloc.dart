import 'package:core_architecture/core_architecture.dart';
import 'package:core_foundation/core_foundation.dart';
import 'package:nasa_picture_domain/nasa_picture_domain.dart';

import 'nasa_picture_list_event.dart';
import 'nasa_picture_list_state.dart';

class NasaPictureListBloc extends BaseBloc<NasaPictureListEvent, NasaPictureListState> {
  final NasaPictureGetListUseCase _getListUseCase;
  final SearchEngine<FilterableNasaPicture> _searchEngine;

  NasaPictureListBloc(this._getListUseCase, this._searchEngine) : super(NasaPictureListState()) {
    on<NasaPictureListStartEvent>(_handleStartEvent);
    on<NasaPictureListSearchEvent>(_handleSearchEvent);
  }

  Future<void> _handleStartEvent(
    NasaPictureListStartEvent event,
    Emitter<NasaPictureListState> emit,
  ) async {
    await emit.forEach(
      _getListUseCase.call(unit),
      onData: (Result<List<NasaPicture>, NasaPictureGetListException> result) => result.when(
        success: (pictures) => state.copy(pictures: pictures),
        exception: (_) => state.copy(error: true),
      )!,
    );
  }

  Future<void> _handleSearchEvent(
    NasaPictureListSearchEvent event,
    Emitter<NasaPictureListState> emit,
  ) async {
    final filteredPictures = _searchEngine
        .matches(event.searchTerm, state.pictures!.map((c) => c.filterable).toList())
        .map((m) => m.source)
        .toList();
    emit(state.copy(searchPictures: filteredPictures));
  }
}
