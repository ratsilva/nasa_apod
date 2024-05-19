import 'package:core_architecture/core_architecture.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:nasa_picture_domain/nasa_picture_domain.dart';
import 'package:nasa_picture_presentation/src/detail/bloc/nasa_picture_detail_bloc.dart';
import 'package:nasa_picture_presentation/src/detail/bloc/nasa_picture_detail_state.dart';
import 'package:nasa_picture_presentation/src/detail/screen/nasa_picture_detail_screen.dart';

import '../mocks/mocks.mocks.dart';

void main() {
  late NasaPicture picture;
  late NasaPictureDetailBloc bloc;

  setUp(() {
    picture = NasaPicture(
      title: "title",
      explanation: "explanation",
      url: "url",
      dateTime: DateTime(2024, 1, 1),
    );

    bloc = MockNasaPictureDetailBloc();
  });

  group('detail screen', () {
    testWidgets('on loading state', (tester) async {
      when(bloc.state).thenReturn(NasaPictureDetailState());
      await tester.pumpDetailScreen(bloc);

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('on success state', (tester) async {
      when(bloc.state).thenReturn(NasaPictureDetailState(picture: picture));
      await tester.pumpDetailScreen(bloc);

      expect(find.text("title"), findsOneWidget);
      expect(find.text("explanation"), findsOneWidget);
    });

    testWidgets('on error state', (tester) async {
      when(bloc.state).thenReturn(NasaPictureDetailState(error: true));
      await tester.pumpDetailScreen(bloc);

      expect(find.text("Ops, something went wrong..."), findsOneWidget);
    });
  });
}

extension on WidgetTester {
  Future<void> pumpDetailScreen(NasaPictureDetailBloc bloc) {
    return pumpWidget(
      MaterialApp(
        home: BaseBlocProvider<NasaPictureDetailBloc, NasaPictureDetailState>(
          create: (_) => bloc,
          builder: (context, state) {
            return NasaPictureDetailScreen(
              state: state,
            );
          },
        ),
      ),
    );
  }
}
