import 'package:flutter_products_demo/core/services/requests/application_request.dart';

class ProductRequest extends ApplicationRequest {
  ProductRequest({required int id})
      : super(
          path: '/https://fakestoreapi.com/products/id',
          header: {},
          body: const {},
        );
}
