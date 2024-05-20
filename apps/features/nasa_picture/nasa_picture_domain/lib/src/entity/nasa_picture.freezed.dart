// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'nasa_picture.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$NasaPicture {
  String get title => throw _privateConstructorUsedError;
  String get explanation => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;
  bool get isValidImage => throw _privateConstructorUsedError;
  DateTime get dateTime => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $NasaPictureCopyWith<NasaPicture> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NasaPictureCopyWith<$Res> {
  factory $NasaPictureCopyWith(
          NasaPicture value, $Res Function(NasaPicture) then) =
      _$NasaPictureCopyWithImpl<$Res, NasaPicture>;
  @useResult
  $Res call(
      {String title,
      String explanation,
      String url,
      bool isValidImage,
      DateTime dateTime});
}

/// @nodoc
class _$NasaPictureCopyWithImpl<$Res, $Val extends NasaPicture>
    implements $NasaPictureCopyWith<$Res> {
  _$NasaPictureCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? explanation = null,
    Object? url = null,
    Object? isValidImage = null,
    Object? dateTime = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      explanation: null == explanation
          ? _value.explanation
          : explanation // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      isValidImage: null == isValidImage
          ? _value.isValidImage
          : isValidImage // ignore: cast_nullable_to_non_nullable
              as bool,
      dateTime: null == dateTime
          ? _value.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NasaPictureImplCopyWith<$Res>
    implements $NasaPictureCopyWith<$Res> {
  factory _$$NasaPictureImplCopyWith(
          _$NasaPictureImpl value, $Res Function(_$NasaPictureImpl) then) =
      __$$NasaPictureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String title,
      String explanation,
      String url,
      bool isValidImage,
      DateTime dateTime});
}

/// @nodoc
class __$$NasaPictureImplCopyWithImpl<$Res>
    extends _$NasaPictureCopyWithImpl<$Res, _$NasaPictureImpl>
    implements _$$NasaPictureImplCopyWith<$Res> {
  __$$NasaPictureImplCopyWithImpl(
      _$NasaPictureImpl _value, $Res Function(_$NasaPictureImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? explanation = null,
    Object? url = null,
    Object? isValidImage = null,
    Object? dateTime = null,
  }) {
    return _then(_$NasaPictureImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      explanation: null == explanation
          ? _value.explanation
          : explanation // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      isValidImage: null == isValidImage
          ? _value.isValidImage
          : isValidImage // ignore: cast_nullable_to_non_nullable
              as bool,
      dateTime: null == dateTime
          ? _value.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _$NasaPictureImpl implements _NasaPicture {
  _$NasaPictureImpl(
      {required this.title,
      required this.explanation,
      required this.url,
      required this.isValidImage,
      required this.dateTime});

  @override
  final String title;
  @override
  final String explanation;
  @override
  final String url;
  @override
  final bool isValidImage;
  @override
  final DateTime dateTime;

  @override
  String toString() {
    return 'NasaPicture(title: $title, explanation: $explanation, url: $url, isValidImage: $isValidImage, dateTime: $dateTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NasaPictureImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.explanation, explanation) ||
                other.explanation == explanation) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.isValidImage, isValidImage) ||
                other.isValidImage == isValidImage) &&
            (identical(other.dateTime, dateTime) ||
                other.dateTime == dateTime));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, title, explanation, url, isValidImage, dateTime);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NasaPictureImplCopyWith<_$NasaPictureImpl> get copyWith =>
      __$$NasaPictureImplCopyWithImpl<_$NasaPictureImpl>(this, _$identity);
}

abstract class _NasaPicture implements NasaPicture {
  factory _NasaPicture(
      {required final String title,
      required final String explanation,
      required final String url,
      required final bool isValidImage,
      required final DateTime dateTime}) = _$NasaPictureImpl;

  @override
  String get title;
  @override
  String get explanation;
  @override
  String get url;
  @override
  bool get isValidImage;
  @override
  DateTime get dateTime;
  @override
  @JsonKey(ignore: true)
  _$$NasaPictureImplCopyWith<_$NasaPictureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
