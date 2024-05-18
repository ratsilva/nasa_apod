import 'package:core_architecture/src/presentation/bloc/base_bloc_provider.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../fixtures/fake_bloc.dart';
import '../../fixtures/fake_provider.dart';
import '../../fixtures/fake_screen.dart';

void main() {
  testWidgets("Verify builder and listener triggered by bloc", (tester) async {
    final bloc = FakeBloc();
    bool listened = false;

    await tester.pumpWidget(BaseBlocProvider<FakeBloc, FakeState>(
      create: (_) => bloc,
      listener: (context, state) => listened = true,
      builder: (context, state) => FakeScreen(state: state),
    ));

    await tester.pump(Duration.zero);
    final textBefore = (tester.widget(find.byType(FakeScreen)) as FakeScreen).state.data;
    expect(textBefore, "");
    expect(listened, false);

    bloc.start();
    await tester.pump(Duration.zero);
    final textAfter = (tester.widget(find.byType(FakeScreen)) as FakeScreen).state.data;
    expect(textAfter, "data");
    expect(listened, true);
  });

  testWidgets("verify bloc is closed on AliceBlocProvider dispose", (tester) async {
    bool closed = false;
    final bloc = FakeBloc(onClose: () => closed = true);
    final blocProvider = FakeProvider(
      child: BaseBlocProvider<FakeBloc, FakeState>(
        create: (_) => bloc,
        builder: (context, state) => FakeScreen(state: state),
      ),
    );

    await tester.pumpWidget(blocProvider);
    await tester.pump(Duration.zero);
    expect(closed, false);

    blocProvider.disposeChild();
    await tester.pumpWidget(blocProvider);
    await tester.pump(Duration.zero);
    expect(closed, true);
  });
}
