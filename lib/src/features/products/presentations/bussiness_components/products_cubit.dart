import 'package:flutter_bloc/flutter_bloc.dart';
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

      emit(state.copyWith(products: products));
    } catch (exception) {
      emit(state.copyWith(
        uiState: ProductUIState.error,
      ));
    }
  }

  void goToCartPage() async {
    emit(state.copyWith(
      uiState: ProductUIState.loading,
      uiPages: ProductUIPages.cartPage,
    ));
  }
}
