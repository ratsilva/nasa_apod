import '../document/page_document.dart';

///
mixin PaginationSource<T extends PageDocument, Params> {
  /// Return a stream with all documents in a single page parsed in [Set<T>] that happens before
  /// [document] limited by [size].
  ///
  /// [document] will be null when fetching the first page.
  Stream<Set<T>> docPageFrom(T? document, int size, Params params);
}
