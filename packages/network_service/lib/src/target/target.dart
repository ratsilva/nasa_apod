import 'http_method.dart';
import 'package:flutter/foundation.dart';
import 'package:collection/collection.dart';

/// Web resource descriptor.
///
/// Implementations of this interface must define the [path] and [method] for accessing a web
/// resource. The [queryParameters] is optional.
abstract class Target {
  String get path;
  HttpMethod get method;
  Map<String, dynamic>? get queryParameters => null;

  @override
  operator ==(Object o) {
    return o is Target &&
        o.path == this.path &&
        o.method == this.method &&
        mapEquals(o.queryParameters, this.queryParameters);
  }

  @override
  int get hashCode {
    return this.path.hashCode ^
        this.method.toString().hashCode ^
        const DeepCollectionEquality().hash(this.queryParameters) ^
        31;
  }
}
