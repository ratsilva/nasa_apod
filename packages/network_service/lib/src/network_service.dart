import 'dart:typed_data';

import 'package:dio/dio.dart';

import 'exception/network_response_exception.dart';
import 'response/response_extensions.dart';
import 'target/http_method.dart';
import 'target/target.dart';

class NetworkService {
  /// HTTP infrastructure
  final Dio _dio;

  const NetworkService(this._dio);

  /// Retrieves a list of [Model] objects. [target] is a required parameter containing all
  /// information needed to reach the correct web resource.
  Future<List<Model>> requestList<Model>(
    Target target,
    Model Function(Map<String, dynamic>) deserializer,
  ) {
    return _requestData(target).then((response) => response.toMap().map(deserializer).toList());
  }

  Future<Response<Uint8List>> _requestData(Target target) async {
    switch (target.method) {
      case HttpMethod.get:
        return _dio
            .get(
              target.path,
              queryParameters: target.queryParameters,
            )
            .then((response) => _validate(response))
            .catchError(_handleRequestError);
      case HttpMethod.post:
        throw UnimplementedError("post method not implemented");
      case HttpMethod.put:
        throw UnimplementedError("put method not implemented");
      case HttpMethod.delete:
        throw UnimplementedError("delete method not implemented");
    }
  }

  Future<Response<Uint8List>> _validate(Response<dynamic> response) {
    final bytes = response.data;
    final statusCode = response.statusCode;
    if (bytes == null || statusCode == null || statusCode < 200 || statusCode >= 300) {
      throw NetworkResponseException.invalidStatusCode();
    }

    final byteArray = Uint8List.fromList(bytes as List<int>);
    final byteResponse = Response<Uint8List>(
      data: byteArray,
      headers: response.headers,
      requestOptions: response.requestOptions,
      isRedirect: response.isRedirect,
      statusCode: response.statusCode,
      statusMessage: response.statusMessage,
      redirects: response.redirects,
      extra: response.extra,
    );
    return Future.value(byteResponse);
  }

  Future<Response<Uint8List>> _handleRequestError(Object error, StackTrace s) {
    if (error is DioException) {
      return Future.error(NetworkResponseException.dioException(error), s);
    }
    return Future.error(error, s);
  }
}
