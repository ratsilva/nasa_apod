import 'package:core_architecture/core_architecture.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:nasa_picture_domain/nasa_picture_domain.dart';
import 'package:nasa_picture_presentation/src/list/bloc/nasa_picture_list_bloc.dart';
import 'package:nasa_picture_presentation/src/list/bloc/nasa_picture_list_state.dart';
import 'package:nasa_picture_presentation/src/list/components/nasa_picture_grid_view.dart';
import 'package:nasa_picture_presentation/src/list/screen/nasa_picture_list_screen.dart';

import '../mocks/mocks.mocks.dart';

void main() {
  late NasaPicture picture;
  late NasaPictureListBloc bloc;

  setUp(() {
    picture = NasaPicture(
      title: "title",
      explanation: "explanation",
      url: "url",
      dateTime: DateTime(2024, 1, 1),
    );

    bloc = MockNasaPictureListBloc();
  });

  group('list screen', () {
    testWidgets('on loading state', (tester) async {
      when(bloc.state).thenReturn(NasaPictureListState());
      await tester.pumpListScreen(bloc);

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('on success state', (tester) async {
      when(bloc.state).thenReturn(NasaPictureListState(pictures: [picture]));
      await tester.pumpListScreen(bloc);

      expect(find.byType(NasaPictureGridView), findsOneWidget);
      expect(find.text("title"), findsOneWidget);
    });

    testWidgets('on error state', (tester) async {
      when(bloc.state).thenReturn(NasaPictureListState(error: true));
      await tester.pumpListScreen(bloc);

      expect(find.text("Ops, something went wrong..."), findsOneWidget);
    });
  });
}

extension on WidgetTester {
  Future<void> pumpListScreen(NasaPictureListBloc bloc) {
    return pumpWidget(
      MaterialApp(
        home: BaseBlocProvider<NasaPictureListBloc, NasaPictureListState>(
          create: (_) => bloc,
          builder: (context, state) {
            return NasaPictureListScreen(
              state: state,
              onSearchChanged: (_) {},
              onItemTapped: (_, __) {},
            );
          },
        ),
      ),
    );
  }
}
