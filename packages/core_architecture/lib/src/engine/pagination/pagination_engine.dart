// import 'package:core_foundation/core_foundation.dart';
import 'package:core_foundation/core_foundation.dart';

import 'document/page_document.dart';
import 'source/pagination_source.dart';

/// Return a stream with all documents parsed in [Set<T>] according to pagination statregy.
/// [nextPageTrigger] will be useful to trigger the next page fetch (including the first fetch),
/// limited by [size].
///
/// It must receives a [params] to identify the correct resource that should be paginated.
class PaginationEngine<T extends PageDocument, Params> {
  final PaginationSource<T, Params> source;

  PaginationEngine(this.source);

  Stream<Set<T>> documents(
    Stream<bool> nextPageTrigger,
    int size,
    Params params,
  ) {
    T? lastDocument;

    return nextPageTrigger
        .switchMap((_) => source
            .docPageFrom(lastDocument, size, params)
            .map((e) => e)
            .defaultIfEmpty({}).onErrorReturn({}))
        .doOnData((docs) => lastDocument = docs.lastOrNull)
        .scan<Set<T>>((acc, value, _) => acc.adding(value), {}).asBroadcastStream();
  }
}
