import 'package:core_architecture/core_architecture.dart';
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

///
extension NasaPictureFilterExtension on NasaPicture {
  FilterableNasaPicture get filterable => FilterableNasaPicture(this);
}

///
class FilterableNasaPicture with Filterable<FilterableNasaPicture> {
  final NasaPicture source;

  FilterableNasaPicture(this.source);

  @override
  Filterable<FilterableNasaPicture>? filter(String searchTerm, FilterMatcher matcher) {
    return (matcher.match(searchTerm, source.title) ||
            matcher.match(searchTerm, source.dateTime.toIso8601String()))
        ? this
        : null;
  }

  @override
  int get hashCode => source.hashCode;

  @override
  bool operator ==(Object other) => (other is FilterableNasaPicture) && other.source == source;
}
