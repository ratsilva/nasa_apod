import 'dart:convert';
import 'dart:typed_data';

import 'package:mockito/mockito.dart';
import 'package:network_service/network_service.dart';
import 'package:network_service/src/exception/network_response_exception.dart';
import 'package:network_service/src/target/http_method.dart';
import 'package:flutter_test/flutter_test.dart';

import 'mocks/mocks.mocks.dart';

void main() {
  late Dio dio;
  late NetworkService networkService;

  setUp(() {
    dio = MockDio();

    networkService = NetworkService(dio);
  });

  group("request list", () {
    late Target target;
    late String rawResponse;
    late Response response;

    setUp(() {
      target = _GetTarget();
    });

    group("get http method", () {
      group("on success", () {
        late List<_DataFromServer> formattedResponse;

        setUp(() {
          rawResponse = "[{\"name\":\"one\"},{\"name\":\"two\"}]";
          formattedResponse = const [_DataFromServer("one"), _DataFromServer("two")];

          response = Response(
            data: Uint8List.fromList(utf8.encode(rawResponse)),
            statusCode: 200,
            requestOptions: RequestOptions(),
          );

          when(dio.get(
            target.path,
            queryParameters: target.queryParameters,
          )).thenAnswer((_) => Future.value(response));
        });

        test("should return data successfully", () async {
          final result = await networkService.requestList<_DataFromServer>(
            target,
            _DataFromServer.fromJson,
          );

          expect(result, formattedResponse);
        });
      });

      group("on error", () {
        group("when not a list", () {
          setUp(() {
            rawResponse = "{\"name\":\"one\"}";

            response = Response(
              data: Uint8List.fromList(utf8.encode(rawResponse)),
              statusCode: 200,
              requestOptions: RequestOptions(),
            );

            when(dio.get(
              target.path,
              queryParameters: target.queryParameters,
            )).thenAnswer((_) => Future.value(response));
          });

          test("should handle error", () {
            expect(
              networkService.requestList<_DataFromServer>(target, _DataFromServer.fromJson),
              throwsA(isA<TypeError>()),
            );
          });
        });

        group("when status code is invalid", () {
          setUp(() {
            rawResponse = "[{\"name\":\"one\"},{\"name\":\"two\"}]";

            response = Response(
              data: Uint8List.fromList(utf8.encode(rawResponse)),
              statusCode: null,
              requestOptions: RequestOptions(),
            );

            when(dio.get(
              target.path,
              queryParameters: target.queryParameters,
            )).thenAnswer((_) => Future.value(response));
          });

          test("should handle error", () {
            expect(
              networkService.requestList<_DataFromServer>(target, _DataFromServer.fromJson),
              throwsA(NetworkResponseException.invalidStatusCode()),
            );
          });
        });

        group("when is dio exception", () {
          late DioException dioException;
          setUp(() {
            dioException = DioException(
              response: Response(data: [0], requestOptions: RequestOptions()),
              requestOptions: RequestOptions(),
            );

            when(dio.get(
              target.path,
              queryParameters: target.queryParameters,
            )).thenAnswer((_) => Future.error(dioException));
          });

          test("should handle error", () {
            expect(
              networkService.requestList<_DataFromServer>(target, _DataFromServer.fromJson),
              throwsA(NetworkResponseException.dioException(dioException)),
            );
          });
        });
      });
    });

    group("put http method", () {
      test("should throw unimplemented error", () {
        final target = _PostTarget();
        expect(
          networkService.requestList<_DataFromServer>(target, _DataFromServer.fromJson),
          throwsA(isA<UnimplementedError>()),
        );
      });
    });

    group("put http method", () {
      test("should throw unimplemented error", () {
        final target = _PutTarget();
        expect(
          networkService.requestList<_DataFromServer>(target, _DataFromServer.fromJson),
          throwsA(isA<UnimplementedError>()),
        );
      });
    });

    group("delete http method", () {
      test("should throw unimplemented error", () {
        final target = _DeleteTarget();
        expect(
          networkService.requestList<_DataFromServer>(target, _DataFromServer.fromJson),
          throwsA(isA<UnimplementedError>()),
        );
      });
    });
  });
}

///
class _DataFromServer {
  final String name;
  const _DataFromServer(this.name);

  factory _DataFromServer.fromJson(Map<String, dynamic> json) {
    return _DataFromServer(json["name"]);
  }

  @override
  operator ==(Object o) {
    return o is _DataFromServer && o.name == name;
  }

  @override
  int get hashCode {
    return name.hashCode ^ 31;
  }
}

///
class _GetTarget extends Target {
  @override
  HttpMethod get method => HttpMethod.get;

  @override
  String get path => "/path";
}

///
class _PostTarget extends Target {
  @override
  HttpMethod get method => HttpMethod.post;

  @override
  String get path => "/path";
}

///
class _PutTarget extends Target {
  @override
  HttpMethod get method => HttpMethod.put;

  @override
  String get path => "/path";
}

///
class _DeleteTarget extends Target {
  @override
  HttpMethod get method => HttpMethod.delete;

  @override
  String get path => "/path";
}
