import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'provider.dart';

/// Defines common parameters for modules that don't need information to be built.
@immutable
class EmptyParameters {}

/// Defines what a [Module] is.
///
/// Every module class in the project need to conform to this protocol. [Module]s are light
/// weight objects that won't do anything until they built.
///
/// Other parts of the application can depend on one or more [Module]s to build
/// the widget or widgets that represent that module.
///
/// [Parameters] is a generic type that can be used to pass information when using [build].
///
/// Every [Module] must also have a [route] to it.
mixin Module<Parameters> {
  String get route;

  Provider build(Parameters parameters);
}
