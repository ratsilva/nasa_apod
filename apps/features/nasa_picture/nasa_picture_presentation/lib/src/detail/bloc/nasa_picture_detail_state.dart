import 'package:nasa_picture_domain/nasa_picture_domain.dart';

class NasaPictureDetailState {
  final NasaPicture? picture;
  final bool error;

  const NasaPictureDetailState({
    this.picture,
    this.error = false,
  });

  bool get loading => picture == null && !error;

  NasaPictureDetailState copy({
    NasaPicture? picture,
    bool? error,
  }) {
    return NasaPictureDetailState(
      picture: picture ?? this.picture,
      error: error ?? this.error,
    );
  }

  @override
  operator ==(Object o) {
    return o is NasaPictureDetailState && o.picture == this.picture && o.error == this.error;
  }

  @override
  int get hashCode {
    return this.picture.hashCode ^ this.error.hashCode ^ 31;
  }
}
