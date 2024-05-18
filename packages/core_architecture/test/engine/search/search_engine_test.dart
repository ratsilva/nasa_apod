import 'package:core_architecture/src/engine/search/filter/filterable.dart';
import 'package:core_architecture/src/engine/search/filter/matcher/filter_matcher.dart';
import 'package:core_architecture/src/engine/search/search_engine.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../mocks/mocks.mocks.dart';

///
void main() {
  final candidates = [_SomeFilterable("candidate 1"), _SomeFilterable("candidate 2")];
  final matcher = MockFilterMatcher();
  final engine = SearchEngine<_SomeFilterable>(matcher);

  test("returns original candidates if term is null", () {
    expect(engine.matches(null, candidates), candidates);
  });

  test("returns empty matches if candidates is emtpy or null", () {
    expect(engine.matches("any", []), []);
    expect(engine.matches("any", null), []);
  });

  test("returns original candidates if term is empty", () {
    expect(engine.matches("", candidates), candidates);
  });

  test("matches each candidate with search term for maching", () {
    const searchTerm = "labs";
    when(matcher.match(searchTerm, "candidate 1")).thenReturn(true);
    when(matcher.match(searchTerm, "candidate 2")).thenReturn(true);

    final matches = engine.matches(searchTerm, candidates);
    expect(matches, candidates);
    verify(matcher.match(searchTerm, "candidate 1")).called(1);
    verify(matcher.match(searchTerm, "candidate 2")).called(1);
    verifyNoMoreInteractions(matcher);
  });

  test("matches every word in term for matching", () {
    const searchTerm = "labs paulista";
    when(matcher.match("labs", "candidate 1")).thenReturn(true);
    when(matcher.match("labs", "candidate 2")).thenReturn(true);
    when(matcher.match("paulista", "candidate 1")).thenReturn(true);
    when(matcher.match("paulista", "candidate 2")).thenReturn(true);

    final matches = engine.matches(searchTerm, candidates);
    expect(matches, candidates);
    verify(matcher.match("labs", "candidate 1")).called(1);
    verify(matcher.match("labs", "candidate 2")).called(1);
    verify(matcher.match("paulista", "candidate 1")).called(1);
    verify(matcher.match("paulista", "candidate 2")).called(1);
    verifyNoMoreInteractions(matcher);
  });

  test("removes null matches from result", () {
    const searchTerm = "labs paulista";
    when(matcher.match("labs", "candidate 1")).thenReturn(false);
    when(matcher.match("labs", "candidate 2")).thenReturn(false);

    final matches = engine.matches(searchTerm, candidates);
    expect(matches, []);
    verify(matcher.match("labs", "candidate 1")).called(1);
    verify(matcher.match("labs", "candidate 2")).called(1);
    verifyNoMoreInteractions(matcher);
  });
}

///
class _SomeFilterable with Filterable<_SomeFilterable> {
  final String value;

  _SomeFilterable(this.value);

  @override
  Filterable<_SomeFilterable>? filter(String searchTerm, FilterMatcher matcher) {
    return matcher.match(searchTerm, value) ? this : null;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  bool operator ==(Object other) {
    return other is _SomeFilterable && other.value == value;
  }
}
