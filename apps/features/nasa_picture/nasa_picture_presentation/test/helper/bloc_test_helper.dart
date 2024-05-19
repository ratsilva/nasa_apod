import 'package:bloc/bloc.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> expectBloc<E, S>(Bloc<E, S> bloc, dynamic matcher) {
  return expectLater(bloc.streamWithInitial.distinct(), matcher);
}

extension BlocStream<E, S> on Bloc<E, S> {
  Stream<S> get streamWithInitial async* {
    yield state;
    yield* stream;
  }
}
