import 'dart:async';

import 'package:core_architecture/core_architecture.dart';

import '../../dto/nasa_picture_dto.dart';
import 'nasa_picture_document.dart';
import 'nasa_picture_pagination_source.dart';

///
class NasaPicturePaginationEngine {
  final PaginationEngine<NasaPicturePageDocument, NasaPictureDocumentParams> _paginationEngine;

  NasaPicturePaginationEngine(this._paginationEngine);

  Stream<List<NasaPictureDto>> pictures({
    required StreamController<bool> nextPageTrigger,
    int pageSize = 15,
  }) {
    final pictureFromDoc = (NasaPicturePageDocument doc) => doc.content;

    final endDate = OverridableDateTime.now;
    final startDate = endDate.subtract(Duration(days: pageSize));

    return _paginationEngine
        .documents(
          nextPageTrigger.stream,
          pageSize,
          NasaPictureDocumentParams(startDate, endDate),
        )
        .map((docs) => docs.map(pictureFromDoc).toList());
  }
}

///
extension OverridableDateTime on DateTime {
  static DateTime? _nowDateTime;

  static DateTime get now {
    return _nowDateTime ?? DateTime.now();
  }

  static set overrideDateTime(DateTime dateTime) {
    _nowDateTime = dateTime;
  }
}
