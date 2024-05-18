import 'package:flutter/widgets.dart';

///
class FakeProvider extends StatefulWidget {
  final Widget child;
  const FakeProvider({Key? key, required this.child}) : super(key: key);

  void disposeChild() {
    _fakeFeatureProviderState?.disposeChild();
  }

  @override
  State<FakeProvider> createState() => _fakeFeatureProviderState ??= _FakeProviderState();
}

class _FakeProviderState extends State<FakeProvider> {
  bool _showChild = true;

  void disposeChild() {
    setState(() {
      _showChild = false;
    });
  }

  @override
  Widget build(BuildContext context) => _showChild ? widget.child : Container();
}

///
_FakeProviderState? _fakeFeatureProviderState;
