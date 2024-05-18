import 'package:core_foundation/src/exception/base_exception.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'result.freezed.dart';

@freezed
class Result<T, E extends BaseException> with _$Result<T, E> {
  const factory Result.success(T value) = _ResultSuccess<T, E>;
  const factory Result.exception(E e) = _ResultException<T, E>;
}
