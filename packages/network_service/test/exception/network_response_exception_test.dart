import 'package:network_service/network_service.dart';
import 'package:network_service/src/exception/network_response_exception.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late NetworkResponseException exception;

  group("dio exception", () {
    late DioException dioException;

    setUp(() {
      dioException = DioException(
        response: Response(data: [0], requestOptions: RequestOptions()),
        requestOptions: RequestOptions(),
        message: "error request",
      );
      exception = NetworkResponseException.dioException(dioException);
    });

    test("toString", () {
      expect(
        exception.toString(),
        "NetworkResponseException(message: Dio exception[error request])",
      );
    });

    group("equality", () {
      test("object", () {
        expect(
          NetworkResponseException.dioException(dioException),
          NetworkResponseException.dioException(dioException),
        );
      });

      test("hashCode", () {
        expect(
          NetworkResponseException.dioException(dioException).hashCode,
          NetworkResponseException.dioException(dioException).hashCode,
        );
      });
    });
  });

  group("invalid status code", () {
    setUp(() {
      exception = NetworkResponseException.invalidStatusCode();
    });

    test("toString", () {
      expect(
        exception.toString(),
        "NetworkResponseException(message: Invalid status code)",
      );
    });

    group("equality", () {
      test("object", () {
        expect(
          NetworkResponseException.invalidStatusCode(),
          NetworkResponseException.invalidStatusCode(),
        );
      });

      test("hashCode", () {
        expect(
          NetworkResponseException.invalidStatusCode().hashCode,
          NetworkResponseException.invalidStatusCode().hashCode,
        );
      });
    });
  });
}
