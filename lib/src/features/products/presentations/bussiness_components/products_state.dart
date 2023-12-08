import 'package:equatable/equatable.dart';
import 'package:flutter_products_demo/src/features/products/domain/models/product_model.dart';

abstract class ProductsState extends Equatable {
  const ProductsState();

  @override
  List<Object?> get props => [];
}

class ProductsInitialState extends ProductsState {
  const ProductsInitialState();
}

class ProductsSuccessState extends ProductsState {
  final List<ProductModel> products;
  const ProductsSuccessState({required this.products});

    @override
  List<Object> get props => [products];
}

class ProductsLoadingState extends ProductsState {
  const ProductsLoadingState();
}

class ProductsErrorState extends ProductsState {
  final String message;

  const ProductsErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
