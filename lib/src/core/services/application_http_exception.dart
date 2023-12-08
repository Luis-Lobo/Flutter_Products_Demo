
import 'package:flutter_products_demo/src/core/services/application_http_messages.dart';

abstract class ApplicationHttpException implements Exception {
  final int code;
  final String prefix;
  final String message;
  final String? cause;

  const ApplicationHttpException({
    required this.code,
    required this.prefix,
    required this.message,
    this.cause,
  });

  @override
  String toString() => '$prefix: $message';
}

class ConnectionException extends ApplicationHttpException {
  const ConnectionException({
    required super.code,
    required super.message,
    super.cause,
  }) : super(
          prefix: ApplicationHttpMessages.connectionException,
        );
}

class AuthenticationException extends ApplicationHttpException {
  const AuthenticationException({
    required super.code,
    required super.message,
  }) : super(
          prefix: ApplicationHttpMessages.authenticationException,
        );
}

class BusinessException extends ApplicationHttpException {
  const BusinessException({
    required super.code,
    required super.message,
  }) : super(
          prefix: ApplicationHttpMessages.businessException,
        );
}

class ServerException extends ApplicationHttpException {
  const ServerException({
    required super.code,
    required super.message,
  }) : super(
          prefix: ApplicationHttpMessages.serverException,
        );
}
