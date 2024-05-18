import 'package:nasa_picture_domain/nasa_picture_domain.dart';
import 'package:flutter/foundation.dart';

class NasaPictureListState {
  final List<NasaPicture>? pictures;
  final bool error;

  const NasaPictureListState({
    this.pictures,
    this.error = false,
  });

  bool get loading => pictures == null && !error;

  List<NasaPicture> get picturesList => pictures ?? [];

  NasaPictureListState copy({
    List<NasaPicture>? pictures,
    bool? error,
  }) {
    return NasaPictureListState(
      pictures: pictures ?? this.pictures,
      error: error ?? this.error,
    );
  }

  @override
  operator ==(Object o) {
    return o is NasaPictureListState &&
        listEquals(o.pictures, this.pictures) &&
        o.error == this.error;
  }

  @override
  int get hashCode {
    return this.pictures.hashCode ^ this.error.hashCode ^ 31;
  }
}
