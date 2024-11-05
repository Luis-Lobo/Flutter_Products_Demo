import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_products_demo/src/features/products/domain/models/product_model.dart';
import 'package:flutter_products_demo/src/features/products/domain/use_cases/use_case_products.dart';
import 'package:flutter_products_demo/src/features/products/presentations/bussiness_components/products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  final ProductsUseCase _useCase;

  ProductsCubit({
    required ProductsUseCase useCase,
  })  : _useCase = useCase,
        super(ProductsState.initial());

  void initialize({ProductUIPages? page}) async {
    emit(state.copyWith(uiState: ProductUIState.loading));

    List<String> imagesUrls = [
      "lib/src/core/assets/images/banner1.jpg",
      "lib/src/core/assets/images/banner2.jpg",
      "lib/src/core/assets/images/banner3.jpg",
      "lib/src/core/assets/images/banner4.jpg",
    ];

    try {
      final products = await _useCase.getProducts();

      emit(state.copyWith(
        uiState: ProductUIState.success,
        uiPages: ProductUIPages.homePage,
        imagesUrls: imagesUrls,
        products: products,
      ));
    } catch (exception) {
      emit(state.copyWith(
        uiState: ProductUIState.error,
      ));
    }
  }

  void goToCartPage() {
    emit(state.copyWith(
      uiState: ProductUIState.loading,
      uiPages: ProductUIPages.cartPage,
    ));
  }

  void goToSearchPage() {
    emit(state.copyWith(
      uiState: ProductUIState.loading,
      uiPages: ProductUIPages.searchPage,
    ));
  }

  void goToPaymentPage() {
    emit(state.copyWith(
      uiState: ProductUIState.loading,
      uiPages: ProductUIPages.paymentPage,
    ));
  }

  void addToCart({required ProductModel product, required List<ProductModel> cartList}) {
    List<ProductModel> updateList = List.from(cartList);
    updateList.add(product);
    calculatePurchasePrice(updateList: updateList);
    emit(state.copyWith(
      uiState: ProductUIState.addedToCart,
      cartList: updateList,
      addProductInCartList: true,
    ));
  }

  void removeToCart({required ProductModel product, required List<ProductModel> cartList}) {
    List<ProductModel> updateList = List.from(cartList);
    updateList.remove(product);
    calculatePurchasePrice(updateList: updateList);
    emit(state.copyWith(
      uiState: ProductUIState.removedToCart,
      cartList: updateList,
      removeProductInCartList: true,
    ));
  }

  void calculatePurchasePrice({required List<ProductModel> updateList}) {
    double totalPurchasePrice = 0.0;
    for (int index = 0; index < updateList.length; index++) {
      totalPurchasePrice += updateList[index].price;
    }
    emit(state.copyWith(
      totalPurchasePrice: totalPurchasePrice,
    ));
  }

  void resetStatesSnackBar() {
    emit(state.copyWith(
      addProductInCartList: false,
      removeProductInCartList: false,
    ));
  }

  void filterProduct({String? query}) {
    if (query == null || query.isEmpty) {
      emit(state.copyWith(
        filterList: state.products,
      ));
    } else {
      List<ProductModel> filterList = state.products.where((model) => model.title.toLowerCase().contains(query.toLowerCase())).toList();

      emit(state.copyWith(
        filterList: filterList,
      ));
    }
  }
}
