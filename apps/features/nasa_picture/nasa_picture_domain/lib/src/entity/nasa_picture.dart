import 'package:freezed_annotation/freezed_annotation.dart';

part 'nasa_picture.freezed.dart';

@freezed
class NasaPicture with _$NasaPicture {
  factory NasaPicture({
    required String title,
    required String explanation,
    required String url,
    required DateTime dateTime,
  }) = _NasaPicture;
}
