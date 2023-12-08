import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_products_demo/src/features/products/domain/use_cases/use_case_products.dart';
import 'package:flutter_products_demo/src/features/products/presentations/bussiness_components/products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
   final ProductsUseCase _useCase;

     ProductsCubit({
    required ProductsUseCase useCase,
  })  : _useCase = useCase,
        super(const ProductsInitialState());

 void getProducts() async {
     try {
      emit(const ProductsLoadingState());

      final products = await _useCase.getProducts();

      emit(ProductsSuccessState(
          products: products));
    } catch (exception) {
      emit(ProductsErrorState(message: exception.toString()));
    }

}
}