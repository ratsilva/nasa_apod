// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Result<T, E extends BaseException> {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(T value) success,
    required TResult Function(E e) exception,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(T value)? success,
    TResult? Function(E e)? exception,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(T value)? success,
    TResult Function(E e)? exception,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ResultSuccess<T, E> value) success,
    required TResult Function(_ResultException<T, E> value) exception,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ResultSuccess<T, E> value)? success,
    TResult? Function(_ResultException<T, E> value)? exception,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ResultSuccess<T, E> value)? success,
    TResult Function(_ResultException<T, E> value)? exception,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ResultCopyWith<T, E extends BaseException, $Res> {
  factory $ResultCopyWith(
          Result<T, E> value, $Res Function(Result<T, E>) then) =
      _$ResultCopyWithImpl<T, E, $Res, Result<T, E>>;
}

/// @nodoc
class _$ResultCopyWithImpl<T, E extends BaseException, $Res,
    $Val extends Result<T, E>> implements $ResultCopyWith<T, E, $Res> {
  _$ResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$ResultSuccessImplCopyWith<T, E extends BaseException, $Res> {
  factory _$$ResultSuccessImplCopyWith(_$ResultSuccessImpl<T, E> value,
          $Res Function(_$ResultSuccessImpl<T, E>) then) =
      __$$ResultSuccessImplCopyWithImpl<T, E, $Res>;
  @useResult
  $Res call({T value});
}

/// @nodoc
class __$$ResultSuccessImplCopyWithImpl<T, E extends BaseException, $Res>
    extends _$ResultCopyWithImpl<T, E, $Res, _$ResultSuccessImpl<T, E>>
    implements _$$ResultSuccessImplCopyWith<T, E, $Res> {
  __$$ResultSuccessImplCopyWithImpl(_$ResultSuccessImpl<T, E> _value,
      $Res Function(_$ResultSuccessImpl<T, E>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
  }) {
    return _then(_$ResultSuccessImpl<T, E>(
      freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as T,
    ));
  }
}

/// @nodoc

class _$ResultSuccessImpl<T, E extends BaseException>
    implements _ResultSuccess<T, E> {
  const _$ResultSuccessImpl(this.value);

  @override
  final T value;

  @override
  String toString() {
    return 'Result<$T, $E>.success(value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ResultSuccessImpl<T, E> &&
            const DeepCollectionEquality().equals(other.value, value));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(value));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ResultSuccessImplCopyWith<T, E, _$ResultSuccessImpl<T, E>> get copyWith =>
      __$$ResultSuccessImplCopyWithImpl<T, E, _$ResultSuccessImpl<T, E>>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(T value) success,
    required TResult Function(E e) exception,
  }) {
    return success(value);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(T value)? success,
    TResult? Function(E e)? exception,
  }) {
    return success?.call(value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(T value)? success,
    TResult Function(E e)? exception,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ResultSuccess<T, E> value) success,
    required TResult Function(_ResultException<T, E> value) exception,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ResultSuccess<T, E> value)? success,
    TResult? Function(_ResultException<T, E> value)? exception,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ResultSuccess<T, E> value)? success,
    TResult Function(_ResultException<T, E> value)? exception,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class _ResultSuccess<T, E extends BaseException>
    implements Result<T, E> {
  const factory _ResultSuccess(final T value) = _$ResultSuccessImpl<T, E>;

  T get value;
  @JsonKey(ignore: true)
  _$$ResultSuccessImplCopyWith<T, E, _$ResultSuccessImpl<T, E>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ResultExceptionImplCopyWith<T, E extends BaseException,
    $Res> {
  factory _$$ResultExceptionImplCopyWith(_$ResultExceptionImpl<T, E> value,
          $Res Function(_$ResultExceptionImpl<T, E>) then) =
      __$$ResultExceptionImplCopyWithImpl<T, E, $Res>;
  @useResult
  $Res call({E e});
}

/// @nodoc
class __$$ResultExceptionImplCopyWithImpl<T, E extends BaseException, $Res>
    extends _$ResultCopyWithImpl<T, E, $Res, _$ResultExceptionImpl<T, E>>
    implements _$$ResultExceptionImplCopyWith<T, E, $Res> {
  __$$ResultExceptionImplCopyWithImpl(_$ResultExceptionImpl<T, E> _value,
      $Res Function(_$ResultExceptionImpl<T, E>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? e = null,
  }) {
    return _then(_$ResultExceptionImpl<T, E>(
      null == e
          ? _value.e
          : e // ignore: cast_nullable_to_non_nullable
              as E,
    ));
  }
}

/// @nodoc

class _$ResultExceptionImpl<T, E extends BaseException>
    implements _ResultException<T, E> {
  const _$ResultExceptionImpl(this.e);

  @override
  final E e;

  @override
  String toString() {
    return 'Result<$T, $E>.exception(e: $e)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ResultExceptionImpl<T, E> &&
            const DeepCollectionEquality().equals(other.e, e));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(e));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ResultExceptionImplCopyWith<T, E, _$ResultExceptionImpl<T, E>>
      get copyWith => __$$ResultExceptionImplCopyWithImpl<T, E,
          _$ResultExceptionImpl<T, E>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(T value) success,
    required TResult Function(E e) exception,
  }) {
    return exception(e);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(T value)? success,
    TResult? Function(E e)? exception,
  }) {
    return exception?.call(e);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(T value)? success,
    TResult Function(E e)? exception,
    required TResult orElse(),
  }) {
    if (exception != null) {
      return exception(e);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ResultSuccess<T, E> value) success,
    required TResult Function(_ResultException<T, E> value) exception,
  }) {
    return exception(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ResultSuccess<T, E> value)? success,
    TResult? Function(_ResultException<T, E> value)? exception,
  }) {
    return exception?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ResultSuccess<T, E> value)? success,
    TResult Function(_ResultException<T, E> value)? exception,
    required TResult orElse(),
  }) {
    if (exception != null) {
      return exception(this);
    }
    return orElse();
  }
}

abstract class _ResultException<T, E extends BaseException>
    implements Result<T, E> {
  const factory _ResultException(final E e) = _$ResultExceptionImpl<T, E>;

  E get e;
  @JsonKey(ignore: true)
  _$$ResultExceptionImplCopyWith<T, E, _$ResultExceptionImpl<T, E>>
      get copyWith => throw _privateConstructorUsedError;
}
