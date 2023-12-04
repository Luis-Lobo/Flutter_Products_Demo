import 'package:flutter_products_demo/core/services/requests/application_request.dart';

abstract class ApplicationHttpClient {
  Future<dynamic> get({
    required ApplicationRequest request,
  });

  Future<dynamic> post({
    required ApplicationRequest request,
  });

  Future<dynamic> put({
    required ApplicationRequest request,
  });
}
