import 'package:core_architecture/src/engine/search/filter/matcher/start_with_filter_matcher.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("match", () {
    test("exact word", () {
      final matcher = StartWithFilterMatcher();
      expect(matcher.match("laboratório", "laboratório"), true);
    });

    test("initial word", () {
      final matcher = StartWithFilterMatcher();
      expect(matcher.match("labo", "laboratório"), true);
    });

    test("is case insensitive for search term", () {
      final matcher = StartWithFilterMatcher();
      expect(matcher.match("LAB", "laboratório"), true);
    });

    test("checks if each candidate word matches", () {
      final matcher = StartWithFilterMatcher();
      const candidate = "SP/laboratorio Av paulista-MASP";
      expect(matcher.match("sp", candidate), true);
      expect(matcher.match("AV", candidate), true);
      expect(matcher.match("lab", candidate), true);
      expect(matcher.match("Paulis", candidate), true);
      expect(matcher.match("masp", candidate), true);
    });

    test("returns true if full word candidate matches", () {
      final matcher = StartWithFilterMatcher();
      const candidate1 = "SP/laboratorio Av paulista-MASP";
      const candidate2 = "SP laboratorio Av paulista";
      expect(matcher.match("SP/laboratorio Av paulista-MASP", candidate1), true);
      expect(matcher.match("SP laboratorio Av paulista", candidate2), true);
    });
  });
}
