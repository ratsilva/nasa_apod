import 'matcher/filter_matcher.dart';

/// Defines an interface for objects that can be filtered.
mixin Filterable<T extends Filterable<T>> {
  /// Objects conforming to this protocol should implement the [filter] method.
  ///
  /// It must return a filtered version of that object considering the [searchTerm]
  /// information. [matcher] can be used to allow for a more
  /// robust match.
  ///
  /// If an object does not fit into the [searchTerm] criteria
  /// it should return `null` in the [filter] call.
  Filterable<T>? filter(String searchTerm, FilterMatcher matcher);
}
