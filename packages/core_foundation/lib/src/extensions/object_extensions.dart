extension ObjectX<T> on T {
  /// Allows accessing nullable values in a more functional way.
  U let<U>(U Function(T) compute) {
    return compute(this);
  }
}
