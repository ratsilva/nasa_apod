import 'package:core_architecture/src/presentation/bloc/base_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

///
/// Bloc
///
class FakeBloc extends BaseBloc<FakeEvent, FakeState> {
  final VoidCallback? onClose;

  FakeBloc({this.onClose}) : super(FakeStateEmpty()) {
    on<FakeEventStart>(_handleStart);
  }

  void _handleStart(FakeEventStart event, Emitter<FakeState> emit) {
    emit(FakeStatePopulated());
  }

  void start() => add(FakeEventStart());

  @override
  Future<void> close() {
    onClose?.call();
    return super.close();
  }
}

///
/// Bloc Event
///
abstract class FakeEvent {}

///
class FakeEventStart implements FakeEvent {}

///
/// Bloc State
///
abstract class FakeState {
  String get data;

  @override
  operator ==(Object o) => o is FakeState && o.data == this.data;

  @override
  int get hashCode => this.data.hashCode ^ 31;
}

///
class FakeStateEmpty implements FakeState {
  @override
  String get data => "";
}

///
class FakeStatePopulated implements FakeState {
  @override
  String get data => "data";
}
