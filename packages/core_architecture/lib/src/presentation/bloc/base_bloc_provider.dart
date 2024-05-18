import 'package:core_foundation/core_foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../screen.dart';
import 'base_bloc.dart';

typedef BlocCreateBuilder<B> = B Function(BuildContext context);
typedef ScreenBuilder<S> = Screen Function(BuildContext context, S state);
typedef ScreenBuildCondition<S> = bool Function(S previous, S current);
typedef StateListener<S> = void Function(BuildContext context, S state);
typedef StateListenCondition<S> = bool Function(S previous, S current);

class BaseBlocProvider<B extends BaseBloc<Object, S>, S> extends StatefulWidget {
  final BlocCreateBuilder<B> create;
  final ScreenBuilder<S> builder;
  final ScreenBuildCondition<S>? buildWhen;
  final StateListener<S>? listener;
  final StateListenCondition<S>? listenWhen;

  const BaseBlocProvider({
    Key? key,
    required this.create,
    required this.builder,
    this.buildWhen,
    this.listener,
    this.listenWhen,
  }) : super(key: key);

  @override
  _BaseBlocProviderState<B, S> createState() => _BaseBlocProviderState<B, S>();
}

class _BaseBlocProviderState<B extends BaseBloc<Object, S>, S>
    extends State<BaseBlocProvider<B, S>> {
  B? _bloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = widget.create.call(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<B, S>(
      bloc: _bloc,
      listenWhen: (previous, current) {
        return widget.listenWhen?.call(previous, current) ?? true;
      },
      listener: (context, state) {
        widget.listener?.let((listener) => listener(context, state));
      },
      buildWhen: (previous, current) {
        return widget.buildWhen?.call(previous, current) ?? true;
      },
      builder: (context, state) {
        return widget.builder(context, state);
      },
    );
  }

  @override
  void dispose() {
    _bloc?.close();
    super.dispose();
  }
}
