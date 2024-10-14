import 'package:equatable/equatable.dart';
import 'package:flutter_products_demo/src/features/products/domain/models/product_model.dart';

class ProductsState extends Equatable {
  final ProductUIState uiState;
  final ProductUIPages uiPages;

  final List<ProductModel> products;
  final List<ProductModel> cartList;
  final double totalPurchasePrice;

  factory ProductsState.initial() => const ProductsState(
        uiState: ProductUIState.initial,
        uiPages: ProductUIPages.homePage,
      );

  const ProductsState({
    required this.uiState,
    required this.uiPages,
    this.products = const [],
    this.cartList = const [],
    this.totalPurchasePrice = 0.0,
  });

  ProductsState copyWith({
    ProductUIState? uiState,
    ProductUIPages? uiPages,
    List<ProductModel>? products,
    List<ProductModel>? cartList,
    double? totalPurchasePrice,
  }) =>
      ProductsState(
        uiState: uiState ?? this.uiState,
        uiPages: uiPages ?? this.uiPages,
        products: products ?? this.products,
        cartList: cartList ?? this.cartList,
        totalPurchasePrice: totalPurchasePrice ?? this.totalPurchasePrice,
      );

  bool get isHomePage => uiPages == ProductUIPages.homePage;
  bool get isCartPage => uiPages == ProductUIPages.cartPage;

  @override
  List<Object?> get props => [
        uiState,
        uiPages,
        products,
        cartList,
        totalPurchasePrice
      ];
}

enum ProductUIState {
  initial,
  loading,
  success,
  error;

  bool get isSuccess => this == ProductUIState.success;

  bool get hasError => this == ProductUIState.error;

  bool get isLoading => this == ProductUIState.loading || this == ProductUIState.initial;
}

enum ProductUIPages { homePage, cartPage }
