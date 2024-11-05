import 'package:flutter_products_demo/src/features/products/data/products_repository.dart';
import 'package:flutter_products_demo/src/features/products/domain/use_cases/use_cases_products_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../../../../fixtures/model_mock.dart';
import 'products_use_case_test.mocks.dart';

@GenerateMocks([], customMocks: [
  MockSpec<ProductsRepository>(as: #ProductsRepositoryMock),
])
void main() {
  final repository = ProductsRepositoryMock();
  final useCase = ProductsUseCaseImpl(repository: repository);
  final productsList = ModelMock.productsList;
  final productModel = ModelMock.productModel;
  final ratingModel = ModelMock.ratingModel;

  group('Tests on Products Use Case', () {
    test('Test get products method', () async {
      when(repository.getProducts()).thenAnswer((_) async => productsList);

      final products = await useCase.getProducts();

      expect(products, isNotNull);
      expect(products.length, 2);
    });

    test('Test get product method', () async {
      when(repository.getProduct(id: 1)).thenAnswer((_) async => productModel);

      final product = await useCase.getProduct(id: 1);

      expect(product, isNotNull);
      expect(product.id, 1);
      expect(product.title, "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops");
      expect(product.price, 109.95);
      expect(product.description, "Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday");
      expect(product.category, "men's clothing");
      expect(product.image, "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg");
      expect(product.rating, ratingModel);
    }); 
  });
}