import 'dart:convert';

import 'package:flutter_products_demo/src/features/authentication/domain/model/user_model.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../../fixtures/fixture_reader.dart';
import '../../../../fixtures/model_mock.dart';

void main() {
  final userModel = ModelMock.userModel;
  test('Test User Model', () {
    expect(userModel, isA<UserModel>());
    expect(userModel.name, "name");
    expect(userModel.email,"email");
    expect(userModel.photoUrl, "photoUrl");
    expect(userModel.props.length, 3);
  });

  test('Test User Model fromJson method', () {
    final userModel = UserModel.fromJson(
     jsonDecode(
        fixture(name: 'user_model.json'),
      ),
    );
    expect(userModel, isA<UserModel>());
    expect(userModel.name, "name");
    expect(userModel.email,"email");
    expect(userModel.photoUrl, "photoUrl");
    expect(userModel.props.length, 3);
  });

  test('Test User Model toJson method', () {
    final json = userModel.toJson();
    expect(json, isA<Map<String, dynamic>>());
    expect(json, isNotNull);
    expect(json, isNotEmpty);
  });
}
