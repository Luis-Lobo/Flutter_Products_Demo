import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_products_demo/src/core/services/application_http_exception.dart';
import 'package:flutter_products_demo/src/features/products/domain/use_cases/use_case_products.dart';
import 'package:flutter_products_demo/src/features/products/domain/use_cases/use_cases_products_impl.dart';
import 'package:flutter_products_demo/src/features/products/presentations/bussiness_components/products_cubit.dart';
import 'package:flutter_products_demo/src/features/products/presentations/bussiness_components/products_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../../../../fixtures/model_mock.dart';
import '../../domain/use_cases/products_use_case_test.mocks.dart';

@GenerateMocks([], customMocks: [MockSpec<ProductsUseCase>(as: #ProductsUseCaseMock)])
void main() {
  final repository = ProductsRepositoryMock();
  final useCase = ProductsUseCaseImpl(repository: repository);
  final productsList = ModelMock.productsList;
  final productModel = ModelMock.productModel;
  final imagesUrls = ModelMock.imagesUrls;

  group('Product State', () {
    test('Test Ui State', () {
      ProductsState prodductsState = ProductsState(
        uiState: ProductUIState.success,
        uiPages: ProductUIPages.homePage,
        addProductInCartList: true,
        cartList: productsList,
        filterList: productsList,
        imagesUrls: imagesUrls,
        products: productsList,
        removeProductInCartList: true,
        totalPurchasePrice: 5.0,
      );

      expect(prodductsState, isA<ProductsState>());
      expect(prodductsState.uiState.isSuccess, true);
      expect(prodductsState.props.length, 9);
    });
  });

  group('Tests on Product Cubit', () {
    blocTest<ProductsCubit, ProductsState>('Test Cubit when initialize is added',
        build: () {
          when(
            useCase.getProducts(),
          ).thenAnswer((_) async => productsList);

          return ProductsCubit(useCase: useCase);
        },
        act: (cubit) => cubit.initialize(),
        expect: () => [
              const ProductsState(uiState: ProductUIState.loading, uiPages: ProductUIPages.homePage),
              ProductsState(uiState: ProductUIState.success, uiPages: ProductUIPages.homePage, imagesUrls: imagesUrls, products: productsList),
            ],
        verify: (cubit) {
          final products = cubit.state.products;
          expect(products, isNotNull);
          expect(products.length, 2);
        });

    blocTest<ProductsCubit, ProductsState>(
      'Test Cubit when initialize receive an Exception',
      build: () {
        when(useCase.getProducts()).thenThrow(
          const BusinessException(code: 1, message: 'test exception'),
        );

        return ProductsCubit(useCase: useCase);
      },
      act: (cubit) => cubit.initialize(),
      expect: () => [
        const ProductsState(uiState: ProductUIState.loading, uiPages: ProductUIPages.homePage),
        const ProductsState(uiState: ProductUIState.error, uiPages: ProductUIPages.homePage),
      ],
      verify: (cubit) {
        expect(cubit.state.uiState, ProductUIState.error);
      },
    );
    blocTest<ProductsCubit, ProductsState>('Test Cubit when goToCartPage is added',
        build: () {
          return ProductsCubit(useCase: useCase);
        },
        act: (cubit) => cubit.goToCartPage(),
        expect: () => [
              const ProductsState(uiState: ProductUIState.loading, uiPages: ProductUIPages.cartPage),
            ],
        verify: (cubit) {
          final uiPages = cubit.state.uiPages;
          expect(uiPages, isNotNull);
          expect(uiPages, ProductUIPages.cartPage);
        });

    blocTest<ProductsCubit, ProductsState>('Test Cubit when searchPage is added',
        build: () {
          return ProductsCubit(useCase: useCase);
        },
        act: (cubit) => cubit.goToSearchPage(),
        expect: () => [
              const ProductsState(uiState: ProductUIState.loading, uiPages: ProductUIPages.searchPage),
            ],
        verify: (cubit) {
          final uiPages = cubit.state.uiPages;
          expect(uiPages, isNotNull);
          expect(uiPages, ProductUIPages.searchPage);
        });

    blocTest<ProductsCubit, ProductsState>('Test Cubit when goToPaymentPage is added',
        build: () {
          return ProductsCubit(useCase: useCase);
        },
        act: (cubit) => cubit.goToPaymentPage(),
        expect: () => [
              const ProductsState(uiState: ProductUIState.loading, uiPages: ProductUIPages.paymentPage),
            ],
        verify: (cubit) {
          final uiPages = cubit.state.uiPages;
          expect(uiPages, isNotNull);
          expect(uiPages, ProductUIPages.paymentPage);
        });

    blocTest<ProductsCubit, ProductsState>('Test Cubit when addToCart is called to add a product to the cart',
        build: () {
          final cubit = ProductsCubit(useCase: useCase);
          cubit.emit(
            const ProductsState(
              uiState: ProductUIState.initial,
              uiPages: ProductUIPages.homePage,
              cartList: [],
            ),
          );
          return cubit;
        },
        act: (cubit) => cubit.addToCart(cartList: cubit.state.cartList, product: productModel),
        expect: () => [
              const ProductsState(
                  uiState: ProductUIState.initial, uiPages: ProductUIPages.homePage, cartList: [], addProductInCartList: false, totalPurchasePrice: 109.95),
              ProductsState(
                  uiState: ProductUIState.addedToCart,
                  uiPages: ProductUIPages.homePage,
                  cartList: [productModel],
                  addProductInCartList: true,
                  totalPurchasePrice: 109.95),
            ],
        verify: (cubit) {
          final cart = cubit.state.cartList;
          expect(cart.length, 1);
          expect(cart.first.title, equals("Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops"));
          expect(cubit.state.totalPurchasePrice, 109.95);
        });

    blocTest<ProductsCubit, ProductsState>(
      'Test Cubit when removeToCart is called to remove a product to the cart',
      build: () {
        final cubit = ProductsCubit(useCase: useCase);
        cubit.emit(
          ProductsState(
            uiState: ProductUIState.initial,
            uiPages: ProductUIPages.homePage,
            cartList: [productModel],
            totalPurchasePrice: 109.95,
          ),
        );
        return cubit;
      },
      act: (cubit) {
        cubit.removeToCart(product: productModel, cartList: cubit.state.cartList);
      },
      expect: () => [
        ProductsState(
            uiState: ProductUIState.initial, 
            uiPages: ProductUIPages.homePage, 
            cartList: [productModel], 
            addProductInCartList: false, 
            totalPurchasePrice: 0.0),
        const ProductsState(
          uiState: ProductUIState.removedToCart,
          uiPages: ProductUIPages.homePage,
          cartList: [],
          totalPurchasePrice: 0.0,
          removeProductInCartList: true,
        ),
      ],
      verify: (cubit) {
        final cart = cubit.state.cartList;
        expect(cart, isEmpty);
        expect(cubit.state.totalPurchasePrice, 0.0);
      },
    );

    blocTest<ProductsCubit, ProductsState>(
      'Test cubit when calculatePurchasePrice is called',
      build: () {
        return ProductsCubit(useCase: useCase);
      },
      act: (cubit) {
        cubit.calculatePurchasePrice(updateList: productsList);
      },
      expect: () => [
        const ProductsState(
          uiState: ProductUIState.initial,
          uiPages: ProductUIPages.homePage,
          totalPurchasePrice: 219.90,
        ),
      ],
      verify: (cubit) {
        expect(cubit.state.totalPurchasePrice, 219.90);
      },
    );

    blocTest<ProductsCubit, ProductsState>('Test Cubit when resetStatesSnackBar is added',
        build: () {
          return ProductsCubit(useCase: useCase);
        },
        act: (cubit) => cubit.resetStatesSnackBar(),
        expect: () => [
              const ProductsState(
                  uiState: ProductUIState.initial, uiPages: ProductUIPages.homePage, addProductInCartList: false, removeProductInCartList: false),
            ],
        verify: (cubit) {
          final uiState = cubit.state.uiState;
          expect(uiState, isNotNull);
        });

    blocTest<ProductsCubit, ProductsState>('Test Cubit when filterProduct is added and it is null',
        build: () {
          return ProductsCubit(useCase: useCase);
        },
        act: (cubit) => cubit.filterProduct(),
        expect: () => [
              const ProductsState(uiState: ProductUIState.initial, uiPages: ProductUIPages.homePage, filterList: const []),
            ],
        verify: (cubit) {
          final filter = cubit.state.filterList;
          expect(filter, isEmpty);
        });
    blocTest<ProductsCubit, ProductsState>('Test Cubit when filterProduct is added and it is not null',
        build: () {
          final cubit = ProductsCubit(useCase: useCase);
          cubit.emit(ProductsState(
            uiState: ProductUIState.initial,
            uiPages: ProductUIPages.homePage,
            products: productsList,
          ));
          return cubit;
        },
        act: (cubit) => cubit.filterProduct(query: "Fjallraven"),
        expect: () => [
              ProductsState(
                  uiState: ProductUIState.initial,
                  uiPages: ProductUIPages.homePage,
                  products: productsList,
                  filterList: productsList.where((model) => model.title.toLowerCase().contains("Fjallraven".toLowerCase())).toList()),
            ],
        verify: (cubit) {
          final filter = cubit.state.filterList;
          expect(filter, isNotEmpty);
          expect(filter.every((model) => model.title.toLowerCase().contains("fjallraven")), isTrue);
        });
  });
}
