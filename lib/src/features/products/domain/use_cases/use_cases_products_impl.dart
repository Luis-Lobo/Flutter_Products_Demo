import 'package:flutter_products_demo/src/features/products/data/products_repository.dart';
import 'package:flutter_products_demo/src/features/products/domain/models/product_model.dart';
import 'package:flutter_products_demo/src/features/products/domain/use_cases/use_case_products.dart';

class ProductsUseCaseImpl implements ProductsUseCase {
  final ProductsRepository _repository;

    const ProductsUseCaseImpl({
    required ProductsRepository repository,
  })  : _repository = repository;


  @override
  Future<List<ProductModel>> getProducts() =>
      _repository.getProducts();

  @override
  Future<ProductModel> getProduct({required int id}) => _repository.getProduct(id: id);

}