import 'package:core_architecture/src/presentation/screen.dart';
import 'package:flutter/material.dart';

import 'fake_bloc.dart';

class FakeScreen extends StatelessWidget with Screen {
  final FakeState state;

  const FakeScreen({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) => Container();
}
