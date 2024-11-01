import 'package:flutter/material.dart';
import 'package:flutter_products_demo/src/features/authentication/domain/model/user_model.dart';

abstract class AuthenticationRepository {
  Future<UserModel?> getUser();

  Future<void> logout(BuildContext context);
}
