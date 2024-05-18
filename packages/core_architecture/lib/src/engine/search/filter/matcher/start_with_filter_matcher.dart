import 'filter_matcher.dart';

/// A [FilterMatcher] that matches candidates that starts with the given [searchTerm].
///
/// This matcher is case insensitive.
class StartWithFilterMatcher implements FilterMatcher {
  @override
  bool match(String searchTerm, String candidate) {
    final lowerCaseSearchTerm = searchTerm.toLowerCase();
    final lowerCaseCandidate = candidate.toLowerCase();
    final candidateWords = lowerCaseCandidate.split(RegExp("[ /\-]+"));
    final hasEmptySearchTerm = searchTerm.isEmpty;

    return hasEmptySearchTerm ||
        lowerCaseCandidate.startsWith(lowerCaseSearchTerm) ||
        candidateWords.where((e) => e.startsWith(lowerCaseSearchTerm)).isNotEmpty;
  }
}
