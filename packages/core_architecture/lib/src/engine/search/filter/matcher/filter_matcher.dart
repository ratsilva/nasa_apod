import 'start_with_filter_matcher.dart';

/// Defines a matcher that knows how to compare a [searchTerm] to a [candidadte].
///
/// see also: [StartWithFilterMatcher].
abstract class FilterMatcher {
  bool match(String searchTerm, String candidate);
}
