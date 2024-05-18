/// Defines a [Provider].
///
/// Classes implementing this protocol are responsible for coordinating [Screen],
/// [Bloc] and child [Module]s.
///
/// Should handle screen interactions that lead to state updates (forwarding to [Bloc]) or that
/// lead to updates in the navigation stack.
mixin Provider {}
