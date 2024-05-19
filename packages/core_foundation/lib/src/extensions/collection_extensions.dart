extension GroupableSet<T> on Set<T> {
  Set<T> addingSets({required List<Set<T>> iterable}) {
    final map = Set<T>.from(this);
    iterable.forEach(map.addAll);
    return map;
  }

  Set<T> adding(Set<T> other) {
    return addingSets(iterable: [other]);
  }
}
