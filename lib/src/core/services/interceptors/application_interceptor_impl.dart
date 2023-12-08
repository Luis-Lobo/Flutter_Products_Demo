import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_products_demo/src/core/services/constants/application_constants.dart';
import 'package:flutter_products_demo/src/core/services/interceptors/application_interceptor.dart';
import 'package:flutter_products_demo/src/core/storage/application_storage.dart';

class ApplicationInterceptorImpl extends ApplicationInterceptor {
  final ApplicationStorage _storage;

  ApplicationInterceptorImpl({
    required ApplicationStorage storage,
  }) : _storage = storage;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final headers = await _updateHeaders(additionalHeaders ?? {});

    options.headers.addAll(headers);

    super.onRequest(options, handler);
  }

  Future<Map<String, dynamic>> _updateHeaders(
    Map<String, dynamic> header,
  ) async {
    if (header.containsKey(ApplicationConstants.authorizationHeader) &&
        header.containsValue(ApplicationConstants.unknownValue)) {
      final token = await _accessToken;
      header.update(
        ApplicationConstants.authorizationHeader,
        (value) => 'Bearer $token',
      );
    }
    return header;
  }

  Future<String?> get _accessToken async {
    final encodedUser = await _storage.loadUser();

    if (encodedUser == null || encodedUser.isEmpty) return null;

    final decodedUser = jsonDecode(encodedUser);

    return decodedUser['access_token'];
  }
}
