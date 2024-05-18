import 'package:core_architecture/core_architecture.dart';
import 'package:flutter/material.dart';
import 'package:nasa_picture_domain/nasa_picture_domain.dart';

import 'bloc/nasa_picture_detail_bloc.dart';
import 'bloc/nasa_picture_detail_event.dart';
import 'bloc/nasa_picture_detail_state.dart';
import 'screen/nasa_picture_detail_screen.dart';

class NasaPictureDetailProvider extends StatefulWidget with Provider {
  final NasaPictureGetUseCase getUseCase;
  final DateTime dateTime;

  const NasaPictureDetailProvider({
    required this.getUseCase,
    required this.dateTime,
    super.key,
  });

  @override
  State<NasaPictureDetailProvider> createState() => _NasaPictureDetailProviderState();
}

class _NasaPictureDetailProviderState extends State<NasaPictureDetailProvider> {
  late NasaPictureDetailBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = NasaPictureDetailBloc(widget.getUseCase);

    _bloc.add(NasaPictureDetailStartEvent(widget.dateTime));
  }

  @override
  Widget build(BuildContext context) {
    return BaseBlocProvider<NasaPictureDetailBloc, NasaPictureDetailState>(
      create: (_) => _bloc,
      builder: (context, state) {
        return NasaPictureDetailScreen(
          state: state,
        );
      },
    );
  }
}
