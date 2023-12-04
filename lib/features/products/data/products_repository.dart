import 'package:flutter_products_demo/features/products/domain/models/product_model.dart';

abstract class ProductsRepository {
  Future<List<ProductModel>> getProducts();

  Future<ProductModel> getProduct({required int id});
}
