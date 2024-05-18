import 'package:core_architecture/src/presentation/screen.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

///
void main() {
  test("screen name", () {
    final name = FakeScreen().name;

    expect(name, "fake");
  });
}

///
class FakeScreen extends StatelessWidget with Screen {
  @override
  Widget build(BuildContext context) => Container();
}
