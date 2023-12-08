import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_products_demo/src/core/services/application_http_client.dart';
import 'package:flutter_products_demo/src/core/services/application_http_exception.dart';
import 'package:flutter_products_demo/src/core/services/application_http_messages.dart';
import 'package:flutter_products_demo/src/core/services/interceptors/application_interceptor.dart';
import 'package:flutter_products_demo/src/core/services/requests/application_request.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioHttpClientImpl implements ApplicationHttpClient {
  final Dio _client;
  final ApplicationInterceptor _interceptor;

  DioHttpClientImpl({
    required ApplicationInterceptor interceptor,
    required Dio client,
  })  : _interceptor = interceptor,
        _client = client;

  @override
  Future<dynamic> post({
    required ApplicationRequest request,
  }) async {
    assert(
      request.path.startsWith('/'),
      'Path parameter must start with "/"!',
    );
    late dynamic response;
    try {
      _interceptor.additionalHeaders = request.header;
      _client.interceptors.clear();
      _client.interceptors.add(_interceptor);
      if (kDebugMode) {
        _client.interceptors.add(PrettyDioLogger());
      }

      response = await _client.post(
        request.path,
        options: Options(headers: request.header),
        data: request.body,
      );
    } on DioException catch (e) {
      _errorHandler(e);
    }
    return response.data;
  }

  @override
  Future<dynamic> get({
    required ApplicationRequest request,
  }) async {
    assert(
      request.path.startsWith('/'),
      'Path parameter must start with "/"!',
    );
    late dynamic response;
    try {
      _interceptor.additionalHeaders = request.header;
      _client.interceptors.clear();
      _client.interceptors.add(_interceptor);
      if (kDebugMode) {
        _client.interceptors.add(PrettyDioLogger());
      }

      response = await _client.get(
        request.path,
        queryParameters: request.queryParameters,
      );
    } on DioException catch (e) {
      _errorHandler(e);
    }
    return response.data;
  }

  @override
  Future<dynamic> put({
    required ApplicationRequest request,
  }) async {
    assert(
      request.path.startsWith('/'),
      'Path parameter must start with "/"!',
    );
    late dynamic response;
    try {
      _interceptor.additionalHeaders = request.header;
      _client.interceptors.clear();
      _client.interceptors.add(_interceptor);
      if (kDebugMode) {
        _client.interceptors.add(PrettyDioLogger());
      }

      response = await _client.put(
        request.path,
        options: Options(headers: request.header),
        data: request.body,
      );
    } on DioException catch (e) {
      _errorHandler(e);
    }
    return response.data;
  }

  void _errorHandler(DioException dioException) {
    var errorId = '';
    var errorMessages = <String>[];
    var errorMessage = 'Erro ao processar a requisição.';
    Exception appException = ConnectionException(
      code: -1,
      message: ApplicationHttpMessages.noInternetConnectionMessage,
      cause: dioException.message,
    );

    if (dioException.response != null) {
      final errorCode = dioException.response?.statusCode ?? -1;

      try {
        errorId = dioException.response?.data['errorId'] ?? '';
        errorMessages = List<String>.from(dioException.response?.data['errors']
            .map((rawData) => rawData['message']));
        errorMessage = '${errorId.trim()} : ${errorMessages.join('.\n')}';
      } catch (_) {}

      if (errorCode == 401 || errorCode == 403) {
        appException = AuthenticationException(
          code: errorCode,
          message: errorMessage,
        );
      } else if (errorCode < 500) {
        appException = BusinessException(
          code: errorCode,
          message: errorMessage,
        );
      } else {
        appException = ServerException(
          code: errorCode,
          message: errorMessage,
        );
      }
    }



    throw appException;
  }
}
