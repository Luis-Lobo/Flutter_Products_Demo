import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_products_demo/src/features/authentication/data/authentication_repository.dart';
import 'package:flutter_products_demo/src/features/authentication/domain/model/user_model.dart';
import 'package:flutter_products_demo/src/features/authentication/domain/use_cases/authentication_use_case.dart';

class AuthenticationUseCaseImpl implements AuthenticationUseCase {
  final AuthenticationRepository _repository;

  const AuthenticationUseCaseImpl({
    required AuthenticationRepository repository,
  }) : _repository = repository;

  @override
  Future<void> registerUser({required String name, 
    required String email, 
    required String password, 
    required File? image})  => _repository.registerUser(
      name: name,
      email: email,
      password: password,
      image: image,
    );
  
  @override
  Future<UserModel?> getUser() => _repository.getUser();

  @override
  Future<void> login({required String email, required String password}) => 
    _repository.login(email: email, password: password);

  @override
  Future<void> logout(BuildContext context) => _repository.logout(context);
}
