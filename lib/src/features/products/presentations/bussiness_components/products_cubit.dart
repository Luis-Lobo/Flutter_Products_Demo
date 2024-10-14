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

    try {
      final products = await _useCase.getProducts();

      emit(state.copyWith(
        products: products,
        uiPages: ProductUIPages.homePage,
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

  void addToCart({required ProductModel product, required List<ProductModel> cartList}) {
    List<ProductModel> updateList = List.from(cartList);
    updateList.add(product);
    calculatePurchasePrice(updateList: updateList);
    emit(state.copyWith(
      cartList: updateList,
    ));
  }

  void removeToCart({required ProductModel product, required List<ProductModel> cartList}) {
    List<ProductModel> updateList = List.from(cartList);
    updateList.remove(product);
    calculatePurchasePrice(updateList: updateList);
    emit(state.copyWith(
      cartList: updateList,
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
}
