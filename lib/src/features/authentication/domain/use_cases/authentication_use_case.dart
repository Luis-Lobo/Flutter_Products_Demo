import 'package:flutter_products_demo/src/features/authentication/domain/model/user_model.dart';

abstract class AuthenticationUseCase {
  Future<UserModel?> getUser();
}
