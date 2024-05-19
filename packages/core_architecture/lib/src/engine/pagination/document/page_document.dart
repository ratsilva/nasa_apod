/// A [PageDocument] represents an instance of each data paginated from remote source. It contains
/// an unique [id] that identify each [PageDocument] on pages and a [content] to wrap the data
/// itself.
mixin PageDocument {
  String get id;

  @override
  int get hashCode => id.hashCode;

  @override
  bool operator ==(Object other) {
    return other is PageDocument && other.id == id;
  }
}
