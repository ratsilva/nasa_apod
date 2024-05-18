/// From [Exception] docs:
///
/// An [Exception] is intended to convey information to the user about a failure,
/// so that the error can be addressed programmatically. It is intended to be
/// caught, and it should contain useful data fields.
class BaseException implements Exception {
  final Object? origin;
  const BaseException([this.origin]);

  @override
  String toString() => "[$runtimeType] origin: $origin";

  @override
  int get hashCode => runtimeType.hashCode ^ origin.hashCode ^ 31;

  @override
  bool operator ==(Object o) {
    return o is BaseException && runtimeType == o.runtimeType && origin == o.origin;
  }
}
