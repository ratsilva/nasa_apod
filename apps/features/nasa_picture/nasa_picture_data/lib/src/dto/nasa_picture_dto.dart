import 'package:json_annotation/json_annotation.dart';
import 'package:nasa_picture_domain/nasa_picture_domain.dart';

part 'nasa_picture_dto.g.dart';

@JsonSerializable()
class NasaPictureDto {
  final String title;
  final String explanation;
  final String url;
  final DateTime dateTime;

  const NasaPictureDto({
    required this.title,
    required this.explanation,
    required this.url,
    required this.dateTime,
  });

  factory NasaPictureDto.fromJson(Map<String, dynamic> json) => _$NasaPictureDtoFromJson(json);

  Map<String, dynamic> toJson() => _$NasaPictureDtoToJson(this);

  NasaPicture toEntity() => NasaPicture(
        title: this.title,
        explanation: this.explanation,
        url: this.url,
        dateTime: this.dateTime,
      );
}
