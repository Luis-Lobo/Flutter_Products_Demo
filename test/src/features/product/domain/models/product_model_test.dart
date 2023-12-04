import 'dart:convert';

import 'package:flutter_products_demo/features/product/domain/product_model.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../../fixtures/fixture_reader.dart';
import '../../../../fixtures/model_mock.dart';

void main() {
  final productModel = ModelMock.productModel;
  test('Test Product Model', () {
    expect(productModel, isA<ProductModel>());
    expect(productModel.id, 1);
    expect(productModel.title,
        "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops");
    expect(productModel.price, 109.95);
    expect(productModel.description,
        "Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday");
    expect(productModel.category, "men's clothing");
    expect(productModel.image,
        "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg");
    expect(productModel.props.length, 6);
  });

  test('Test Product Model fromJson method', () {
    final productModel = ProductModel.fromJson(
      json: jsonDecode(
        fixture(name: 'product_model.json'),
      ),
    );
    expect(productModel, isA<ProductModel>());
    expect(productModel.id, 1);
    expect(productModel.title,
        "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops");
    expect(productModel.price, 109.95);
    expect(productModel.description,
        "Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday");
    expect(productModel.category, "men's clothing");
    expect(productModel.image,
        "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg");
    expect(productModel.props.length, 6);
  });

  test('Test Product Model toJson method', () {
    final json = productModel.toJson();
    expect(json, isA<Map<String, dynamic>>());
    expect(json, isNotNull);
    expect(json, isNotEmpty);
  });
}
