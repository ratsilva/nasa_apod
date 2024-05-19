import 'dart:async';

import 'package:core_architecture/core_architecture.dart';
import 'package:mockito/annotations.dart';
import 'package:nasa_picture_domain/nasa_picture_domain.dart';
import 'package:nasa_picture_presentation/src/detail/bloc/nasa_picture_detail_bloc.dart';
import 'package:nasa_picture_presentation/src/list/bloc/nasa_picture_list_bloc.dart';

@GenerateNiceMocks([
  MockSpec<NasaPictureGetListUseCase>(),
  MockSpec<NasaPictureGetUseCase>(),
  MockSpec<SearchEngine<FilterableNasaPicture>>(),
  MockSpec<NasaPictureListBloc>(),
  MockSpec<NasaPictureDetailBloc>(),
  MockSpec<StreamController<bool>>(),
])
class Mocks {}
