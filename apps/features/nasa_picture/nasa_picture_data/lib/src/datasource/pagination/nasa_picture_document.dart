import 'package:core_architecture/core_architecture.dart';

import '../../dto/nasa_picture_dto.dart';

class NasaPicturePageDocument with PageDocument {
  @override
  String get id => content.dateTime.toIso8601String();
  final NasaPictureDto content;

  NasaPicturePageDocument(this.content);
}
