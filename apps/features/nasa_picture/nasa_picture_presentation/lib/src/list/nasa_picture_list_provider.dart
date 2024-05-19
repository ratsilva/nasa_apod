import 'package:core_architecture/core_architecture.dart';
import 'package:flutter/material.dart';
import 'package:nasa_picture_domain/nasa_picture_domain.dart';

import '../detail/nasa_picture_detail_module.dart';
import '../navigation/nasa_picture_navigation.dart';
import 'bloc/nasa_picture_list_bloc.dart';
import 'bloc/nasa_picture_list_event.dart';
import 'bloc/nasa_picture_list_state.dart';
import 'screen/nasa_picture_list_screen.dart';

class NasaPictureListProvider extends StatefulWidget with Provider {
  final NasaPictureDetailModule detailModule;
  final NasaPictureGetListUseCase getListUseCase;
  final SearchEngine<FilterableNasaPicture> searchEngine;

  const NasaPictureListProvider({
    required this.detailModule,
    required this.getListUseCase,
    required this.searchEngine,
    super.key,
  });

  @override
  State<NasaPictureListProvider> createState() => _NasaPictureListProviderState();
}

class _NasaPictureListProviderState extends State<NasaPictureListProvider> {
  late NasaPictureListBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = NasaPictureListBloc(widget.getListUseCase, widget.searchEngine);

    _bloc.add(NasaPictureListStartEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BaseBlocProvider<NasaPictureListBloc, NasaPictureListState>(
      create: (_) => _bloc,
      builder: (context, state) {
        return NasaPictureListScreen(
          state: state,
          onSearchChanged: _handleOnSearchChanged,
          onItemTapped: _handleOnItemTapped,
        );
      },
    );
  }

  void _handleOnSearchChanged(String searchTerm) {
    _bloc.add(NasaPictureListSearchEvent(searchTerm));
  }

  void _handleOnItemTapped(NasaPicture picture, BuildContext context) {
    FocusScope.of(context).unfocus();
    context.pushNamed(
      NasaPictureRoutes.details.name,
      extra: NasaPictureDetailModuleParameters(dateTime: picture.dateTime),
    );
  }
}
