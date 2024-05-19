import 'dart:async';

import 'package:core_architecture/src/engine/pagination/document/page_document.dart';
import 'package:core_architecture/src/engine/pagination/pagination_engine.dart';
import 'package:core_architecture/src/engine/pagination/source/pagination_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../mocks/mocks.mocks.dart';

void main() {
  late PaginationSource<FakeDocument, String> source;
  late PaginationEngine engine;

  setUp(() {
    source = MockPaginationSource<FakeDocument, String>();

    engine = PaginationEngine(source);
  });

  group("messages only from past", () {
    late Set<FakeDocument> firstPage;
    late Set<FakeDocument> secondPage;

    setUp(() {
      firstPage = {
        FakeDocument("1"),
        FakeDocument("2"),
      };
      secondPage = {
        FakeDocument("3"),
        FakeDocument("4"),
      };

      /// First page default data
      when(source.docPageFrom(null, 2, "")).thenAnswer((_) => Stream.value(firstPage));

      /// Second page default data
      when(source.docPageFrom(FakeDocument("2"), 2, ""))
          .thenAnswer((_) => Stream.value(secondPage));
    });

    test("first page", () async {
      final nextPageTrigger = StreamController<bool>();
      expectLater(
        engine.documents(nextPageTrigger.stream, 2, "").map((set) => set.toList()),
        emitsInOrder([
          [
            FakeDocument("1"),
            FakeDocument("2"),
          ]
        ]),
      );

      nextPageTrigger.add(true);
    });

    test("first page with error", () async {
      final nextPageTrigger = StreamController<bool>();

      when(source.docPageFrom(null, 2, "")).thenAnswer((_) => Stream.error("error"));

      expectLater(
        engine.documents(nextPageTrigger.stream, 2, "").map((set) => set.toList()),
        emitsInOrder([
          <FakeDocument>[],
        ]),
      );

      nextPageTrigger.add(true);
    });

    test("first page and second page", () async {
      final nextPageTrigger = StreamController<bool>();

      expectLater(
        engine.documents(nextPageTrigger.stream, 2, "").map((set) => set.toList()),
        emitsInOrder([
          [
            FakeDocument("1"),
            FakeDocument("2"),
          ],
          [
            FakeDocument("1"),
            FakeDocument("2"),
            FakeDocument("3"),
            FakeDocument("4"),
          ],
        ]),
      );

      nextPageTrigger.add(true);
      nextPageTrigger.add(true);
    });

    test("first page and second page with error", () async {
      final nextPageTrigger = StreamController<bool>();

      when(source.docPageFrom(FakeDocument("2"), 2, "")).thenAnswer((_) => Stream.error("error"));

      expectLater(
        engine.documents(nextPageTrigger.stream, 2, "").map((set) => set.toList()),
        emitsInOrder([
          [
            FakeDocument("1"),
            FakeDocument("2"),
          ],
          [
            FakeDocument("1"),
            FakeDocument("2"),
          ],
        ]),
      );

      nextPageTrigger.add(true);

      nextPageTrigger.add(true);
    });
  });
}

///
class FakeDocument with PageDocument {
  @override
  final String id;

  FakeDocument(this.id);

  @override
  String toString() => id;
}
