import 'package:collection/collection.dart';

import 'filter/matcher/filter_matcher.dart';
import 'filter/filterable.dart';

class SearchEngine<T extends Filterable<T>> {
  final FilterMatcher _matcher;

  SearchEngine(this._matcher);

  List<T> matches(String? searchTerm, List<T>? candidates) {
    if ((searchTerm ?? "").isEmpty || (candidates ?? []).isEmpty) {
      return candidates ?? [];
    }

    List<Filterable<T>> result = candidates ?? [];

    final searchTerms = searchTerm?.split(" ") ?? [];

    for (final term in searchTerms) {
      result = result.map((candidate) => candidate.filter(term, _matcher)).whereNotNull().toList();
    }

    return List<T>.from(result);
  }
}
