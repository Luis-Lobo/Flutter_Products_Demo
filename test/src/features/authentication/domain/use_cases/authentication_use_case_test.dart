import 'dart:io';
import 'package:flutter/material.dart';

import 'package:flutter_products_demo/src/features/authentication/data/authentication_repository.dart';
import 'package:flutter_products_demo/src/features/authentication/domain/use_cases/authentication_use_case_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/model_mock.dart';
import 'authentication_use_case_test.mocks.dart';

@GenerateMocks([], customMocks: [
  MockSpec<AuthenticationRepository>(as: #AutenticationRepositoryMock),
  MockSpec<BuildContext>(as: #MockBuildContext),
])
void main() {
  final repository = AutenticationRepositoryMock();
  final useCase = AuthenticationUseCaseImpl(repository: repository);
  final userModel = ModelMock.userModel;

  const String email = 'email';
  const String password = 'password';
  const String name = 'name';
  final File image = File('lib/src/core/assets/images/marketing.jpg');

  group('Tests on Authentication Use Case', () {
    test('Test resisterUser method. It does not return anything', () async {
      when(repository.registerUser(
        email: email,
        password: password,
        name: name,
        image: image,
      )).thenAnswer((_) async => Future.value());

      final newUser = await useCase.registerUser(
        email: email,
        password: password,
        name: name,
        image: image,
      );

      expect(() async => newUser, isA<void>());

      verify(repository.registerUser(
            email: email,
            password: password,
            name: name,
            image: image,
          )).called(1); 
    });

    test('Test getUser method. It returns UserModel from repository', () async {
      when(repository.getUser()).thenAnswer((_) async => userModel);

      final user = await useCase.getUser();

      expect(user, userModel);

      verify(repository.getUser()).called(1);
    });

    test('Test login method. It calls repository with correct parameters', () async {
      when(repository.login(email: email, password: password)).thenAnswer((_) async => Future.value());

      await useCase.login(email: email, password: password);

      verify(repository.login(email: email, password: password)).called(1);
    });

    test('Test logout method. It calls repository with correct context', () async {
      final context = MockBuildContext();

      when(repository.logout(context)).thenAnswer((_) async => Future.value());

      await useCase.logout(context);

      verify(repository.logout(context)).called(1);
    });

    test('Test recoverPassword method. It calls repository with correct context', () async {

      when(repository.recoverPassword(email: 'email')).thenAnswer((_) async => Future.value());

      await useCase.recoverPassword(email: 'email');

      verify(repository.recoverPassword(email: 'email')).called(1);
    });
  });
}
