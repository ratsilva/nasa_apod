part of 'nasa_picture_navigation.dart';

enum NasaPictureRoutes {
  list(
    name: 'nasa_picture_list',
    path: '/nasa_picture_list',
  ),
  details(
    name: 'nasa_picture_detail',
    path: '/nasa_picture_detail',
  );

  const NasaPictureRoutes({
    required this.name,
    required this.path,
  });

  final String name;
  final String path;
}
