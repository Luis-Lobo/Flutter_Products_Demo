import 'package:flutter_products_demo/core/services/requests/application_request.dart';

class ProductsRequest extends ApplicationRequest {
  ProductsRequest()
      : super(
          path: '/https://fakestoreapi.com/products',
          header: {},
          body: const {},
        );
}
