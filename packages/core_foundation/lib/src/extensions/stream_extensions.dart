import '../exception/base_exception.dart';
import '../types/result.dart';

import 'package:rxdart/rxdart.dart';

extension StreamX<T> on Stream<T> {
  Stream<Result<T, E>> foldResult<E extends BaseException>(
    E Function(Object, StackTrace) errorMapper,
  ) {
    return map(
      (value) => Result<T, E>.success(value),
    ).onErrorReturnWith(
      (e, s) => Result.exception(errorMapper.call(e, s)),
    );
  }
}
