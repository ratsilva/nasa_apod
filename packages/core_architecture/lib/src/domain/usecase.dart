import 'package:core_foundation/core_foundation.dart';

/// Defines an interface for domain actions.
///
/// An [UseCase] represents the domain layer's actions. It defines all actions that application's
/// actors can perform. In other words, it defines what the application can do.
mixin UseCase<P, E> {
  Stream<Result<E, BaseException>> call(P params);
}
