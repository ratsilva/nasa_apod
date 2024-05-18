import 'package:core_architecture/core_architecture.dart';
import 'package:core_foundation/core_foundation.dart';
import 'package:nasa_picture_domain/nasa_picture_domain.dart';

import 'nasa_picture_detail_event.dart';
import 'nasa_picture_detail_state.dart';

class NasaPictureDetailBloc extends BaseBloc<NasaPictureDetailEvent, NasaPictureDetailState> {
  final NasaPictureGetUseCase _getUseCase;

  NasaPictureDetailBloc(this._getUseCase) : super(NasaPictureDetailState()) {
    on<NasaPictureDetailStartEvent>(_handleStartEvent);
  }

  Future<void> _handleStartEvent(
    NasaPictureDetailStartEvent event,
    Emitter<NasaPictureDetailState> emit,
  ) async {
    await emit.forEach(
      _getUseCase.call(event.dateTime),
      onData: (Result<NasaPicture, NasaPictureGetException> result) => result.when(
        success: (picture) => state.copy(picture: picture),
        exception: (_) => state.copy(error: true),
      )!,
    );
  }
}
