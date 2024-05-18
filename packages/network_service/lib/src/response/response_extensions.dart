import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';

extension MapExtensions on Response<Uint8List> {
  List<Map<String, dynamic>> toMap() {
    return List<Map<String, dynamic>>.from(json.decode(_decode) as List);
  }

  String get _decode => const Utf8Codec().decode(this.data ?? Uint8List(0));
}
