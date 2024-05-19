import 'dart:async';

import 'package:core_architecture/core_architecture.dart';
import 'package:core_foundation/core_foundation.dart';
import 'package:nasa_picture_domain/nasa_picture_domain.dart';

import 'nasa_picture_list_event.dart';
import 'nasa_picture_list_state.dart';

///
typedef StreamControllerBuilder = StreamController<bool>? Function();

///
class NasaPictureListBloc extends BaseBloc<NasaPictureListEvent, NasaPictureListState> {
  final NasaPictureGetListUseCase _getListUseCase;
  final SearchEngine<FilterableNasaPicture> _searchEngine;
  final StreamControllerBuilder? _streamBuilder;

  NasaPictureListBloc(
    this._getListUseCase,
    this._searchEngine, {
    StreamControllerBuilder? streamBuilder,
    Function(String)? onPaginationEnded,
  })  : this._streamBuilder = streamBuilder,
        super(NasaPictureListState()) {
    on<NasaPictureListStartEvent>(_handleStartEvent);
    on<NasaPictureListSearchEvent>(_handleSearchEvent);
    on<NasaPictureListNextPageEvent>(_handleNextPageEvent);
  }

  StreamController<bool>? _pageTriggerController;

  Future<void> _handleStartEvent(
    NasaPictureListStartEvent event,
    Emitter<NasaPictureListState> emit,
  ) async {
    _pageTriggerController?.close();
    final trigger = _pageTriggerController = _streamBuilder?.call() ?? StreamController<bool>();
    trigger.add(true);
    await emit.forEach(
      _getListUseCase.call(trigger),
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

  Future<void> _handleNextPageEvent(
    NasaPictureListNextPageEvent event,
    Emitter<NasaPictureListState> emit,
  ) async {
    if (_pageTriggerController?.isClosed == false) {
      _pageTriggerController?.add(true);
      return;
    }
  }

  @override
  Future<void> close() {
    _pageTriggerController?.close();
    return super.close();
  }
}
