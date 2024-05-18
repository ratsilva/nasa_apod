import 'package:flutter/widgets.dart';
import 'package:recase/recase.dart';

/// Defines what a [Screen] is.
///
/// Screens must conform to the [Widget] type. Every [Module]'s screen need to conform to the
/// [Screen] protocol.
///
/// Conforming to this protocol gives it [name] information that can be override if needed.
mixin Screen implements Widget {
  String get name {
    return (runtimeType.toString().snakeCase.split("_")..removeLast()).join("_");
  }
}
