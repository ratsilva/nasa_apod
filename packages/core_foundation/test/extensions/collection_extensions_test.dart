import 'package:core_foundation/src/extensions/collection_extensions.dart';
import 'package:test/test.dart';

void main() {
  group("groupable set", () {
    group("adding set", () {
      test("both sets empty", () {
        final currentSet = <String>{};
        final incomingSet = <String>{};
        final combinedSets = currentSet.adding(incomingSet);
        expect(combinedSets.length, 0);
      });

      test("current set empty", () {
        final currentSet = <String>{};
        final incomingSet = <String>{"value10"};
        final combinedSets = currentSet.adding(incomingSet);
        expect(combinedSets.length, 1);
        expect(combinedSets.contains("value10"), true);
      });

      test("incoming set empty", () {
        final currentSet = <String>{"value1"};
        final incomingSet = <String>{};
        final combinedSets = currentSet.adding(incomingSet);
        expect(combinedSets.length, 1);
        expect(combinedSets.contains("value1"), true);
      });

      test("sets completely differents", () {
        final currentSet = <String>{"value1", "value2"};
        final incomingSet = <String>{"value10", "value20"};
        final combinedSets = currentSet.adding(incomingSet);
        expect(combinedSets.length, 4);
        expect(combinedSets.contains("value1"), true);
        expect(combinedSets.contains("value2"), true);
        expect(combinedSets.contains("value10"), true);
        expect(combinedSets.contains("value20"), true);
      });

      test("sets with mutual ids", () {
        final currentSet = <String>{"value1", "value2", "value10"};
        final incomingSet = <String>{"value10", "value20", "value1"};
        final combinedSets = currentSet.adding(incomingSet);
        expect(combinedSets.length, 4);
        expect(combinedSets.contains("value1"), true);
        expect(combinedSets.contains("value2"), true);
        expect(combinedSets.contains("value10"), true);
        expect(combinedSets.contains("value20"), true);
      });
    });
  });
}
