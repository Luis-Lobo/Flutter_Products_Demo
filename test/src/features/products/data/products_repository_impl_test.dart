import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_products_demo/src/core/services/dio_http_client_impl.dart';
import 'package:flutter_products_demo/src/core/services/requests/product_request.dart';
import 'package:flutter_products_demo/src/core/services/requests/products_request.dart';
import 'package:flutter_products_demo/src/features/products/data/products_repositoyy_impl.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import '../../../fixtures/fixture_reader.dart';
import '../../../mocks/application_interceptor_mock.dart';

void main() {
  final dio = Dio(BaseOptions());
  final dioAdapter = DioAdapter(dio: dio);
  final interceptor = ApplicationInterceptorMock();
  final httpClient = DioHttpClientImpl(client: dio, interceptor: interceptor);
  final productsRepository = ProductsRepositoryImpl(
    httpClient: httpClient,
  );

  test('Test Products Request method success with data', () async {
    final request = ProductsRequest();
    dioAdapter.onGet(
        request.path,
        (server) => server.reply(
              200,
              jsonDecode(
                fixture(name: 'product_model_list.json'),
              ),
            ));

    expectLater(
      () => productsRepository.getProducts(),
      returnsNormally,
    );
  });

  test('Test Product Request method success with data', () async {
    final request = ProductRequest(id: 1);
    dioAdapter.onGet(
        request.path,
        (server) => server.reply(
              200,
              jsonDecode(
                fixture(name: 'product_model.json'),
              ),
            ));

    expectLater(
      () => productsRepository.getProduct(id: 1),
      returnsNormally,
    );
  });
}
