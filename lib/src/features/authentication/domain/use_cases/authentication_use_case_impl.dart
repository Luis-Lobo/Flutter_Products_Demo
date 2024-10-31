import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';
import 'package:flutter_products_demo/src/features/authentication/data/authentication_repository.dart';
import 'package:flutter_products_demo/src/features/authentication/domain/model/user_model.dart';
import 'package:flutter_products_demo/src/features/authentication/domain/use_cases/authentication_use_case.dart';

class AuthenticationUseCaseImpl implements AuthenticationUseCase {
  final AuthenticationRepository _repository;

  const AuthenticationUseCaseImpl({
    required AuthenticationRepository repository,
  })  : _repository = repository;


  @override
  Future<UserModel?> getUser() => _repository.getUser();


}
