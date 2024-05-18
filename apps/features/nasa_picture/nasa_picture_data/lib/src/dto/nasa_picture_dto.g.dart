// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nasa_picture_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NasaPictureDto _$NasaPictureDtoFromJson(Map<String, dynamic> json) =>
    NasaPictureDto(
      title: json['title'] as String,
      explanation: json['explanation'] as String,
      url: json['url'] as String,
      dateTime: DateTime.parse(json['date'] as String),
    );

Map<String, dynamic> _$NasaPictureDtoToJson(NasaPictureDto instance) =>
    <String, dynamic>{
      'title': instance.title,
      'explanation': instance.explanation,
      'url': instance.url,
      'date': instance.dateTime.toIso8601String(),
    };
