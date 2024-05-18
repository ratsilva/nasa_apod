import 'package:core_architecture/core_architecture.dart';
import 'package:nasa_picture_presentation/nasa_picture_presentation.dart';

part 'nasa_picture_routes.dart';

class NasaPictureNavigation implements AppNavigation {
  final NasaPictureListModule _listModule;
  final NasaPictureDetailModule _detailModule;

  const NasaPictureNavigation(this._listModule, this._detailModule);

  @override
  List<GoRoute> get routes => [
        GoRoute(
          name: NasaPictureRoutes.list.name,
          path: NasaPictureRoutes.list.path,
          builder: (context, state) {
            return _listModule.build(EmptyParameters());
          },
        ),
        GoRoute(
          name: NasaPictureRoutes.details.name,
          path: NasaPictureRoutes.details.path,
          builder: (context, state) {
            final params = state.extra as NasaPictureDetailModuleParameters;
            return _detailModule.build(params);
          },
        ),
      ];
}
