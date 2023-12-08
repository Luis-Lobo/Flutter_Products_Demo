import 'package:flutter_products_demo/src/core/services/application_http_client.dart';
import 'package:flutter_products_demo/src/core/services/requests/product_request.dart';
import 'package:flutter_products_demo/src/core/services/requests/products_request.dart';
import 'package:flutter_products_demo/src/features/products/data/products_repository.dart';
import 'package:flutter_products_demo/src/features/products/domain/models/product_model.dart';

class ProductsRepositoryImpl implements ProductsRepository {
  final ApplicationHttpClient _httpClient;

  const ProductsRepositoryImpl({
    required ApplicationHttpClient httpClient,
  }) : _httpClient = httpClient;

  @override
  Future<List<ProductModel>> getProducts() async {
    final request = ProductsRequest();

    final response = await _httpClient.get(
      request: request,
    );
    return List<ProductModel>.from(
      response.map(
        (data) => ProductModel.fromJson(json: data),
      ),
    );
  }

  @override
  Future<ProductModel> getProduct({required int id}) async {
    final request = ProductRequest(id: id);

    final response = await _httpClient.get(
      request: request,
    );

    return ProductModel.fromJson(json: response);
  }
}
