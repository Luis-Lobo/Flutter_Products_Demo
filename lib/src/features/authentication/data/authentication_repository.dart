import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_products_demo/src/features/authentication/domain/model/user_model.dart';

abstract class AuthenticationRepository {
  Future<void> registerUser({
    required String name, 
    required String email, 
    required String password, 
    required File? image});

  Future<UserModel?> getUser();

  Future<void> login({required String email, required String password});

  Future<void> logout(BuildContext context);
  
  Future<void> recoverPassword({required String email});
}
