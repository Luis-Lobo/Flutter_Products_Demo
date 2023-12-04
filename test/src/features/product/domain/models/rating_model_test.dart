import 'dart:convert';
import 'package:flutter_products_demo/features/product/domain/rating_model.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../../fixtures/fixture_reader.dart';
import '../../../../fixtures/model_mock.dart';

void main() {
  final ratingModel = ModelMock.ratingModel;
  test('Test Rating Model', () {
    expect(ratingModel, isA<RatingModel>());
    expect(ratingModel.rate, 3.9);
    expect(ratingModel.count, 120);
    expect(ratingModel.props.length, 2);
  });

  test('Test Rating Model fromJson method', () {
    final ratingModel = RatingModel.fromJson(
      json: jsonDecode(
        fixture(name: 'rating_model.json'),
      ),
    );
    expect(ratingModel, isA<RatingModel>());
    expect(ratingModel.rate, 3.9);
    expect(ratingModel.count, 120);
    expect(ratingModel.props.length, 2);
  });

  test('Test Rating Model toJson method', () {
    final json = ratingModel.toJson();
    expect(json, isA<Map<String, dynamic>>());
    expect(json, isNotNull);
    expect(json, isNotEmpty);
  });
}
