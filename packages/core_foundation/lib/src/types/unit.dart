const unit = Unit._();

class Unit {
  const Unit._();

  @override
  int get hashCode => unit.runtimeType.hashCode;

  @override
  bool operator ==(Object o) => o is Unit;
}
