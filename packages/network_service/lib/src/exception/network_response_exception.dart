import 'package:dio/dio.dart';

class NetworkResponseException implements Exception {
  final String message;

  const NetworkResponseException._({required this.message});

  static NetworkResponseException dioException(DioException exception) {
    return NetworkResponseException._(
      message: "Dio exception[${exception.message}]",
    );
  }

  static NetworkResponseException invalidStatusCode() {
    return NetworkResponseException._(
      message: "Invalid status code",
    );
  }

  @override
  operator ==(Object o) {
    return o is NetworkResponseException && o.message == this.message;
  }

  @override
  int get hashCode {
    return this.message.hashCode ^ 31;
  }

  @override
  String toString() => 'NetworkResponseException(message: $message)';
}
