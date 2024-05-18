import 'package:nasa_picture_domain/nasa_picture_domain.dart';
import 'package:flutter/foundation.dart';

class NasaPictureListState {
  final List<NasaPicture>? pictures;
  final List<NasaPicture>? searchPictures;
  final bool error;

  const NasaPictureListState({
    this.pictures,
    this.searchPictures,
    this.error = false,
  });

  bool get loading => pictures == null && !error;

  List<NasaPicture> get picturesList => searchPictures ?? pictures ?? [];

  NasaPictureListState copy({
    List<NasaPicture>? pictures,
    List<NasaPicture>? searchPictures,
    bool? error,
  }) {
    return NasaPictureListState(
      pictures: pictures ?? this.pictures,
      searchPictures: searchPictures ?? this.searchPictures,
      error: error ?? this.error,
    );
  }

  @override
  operator ==(Object o) {
    return o is NasaPictureListState &&
        listEquals(o.pictures, this.pictures) &&
        listEquals(o.searchPictures, this.searchPictures) &&
        o.error == this.error;
  }

  @override
  int get hashCode {
    return this.pictures.hashCode ^ this.searchPictures.hashCode ^ this.error.hashCode ^ 31;
  }
}
