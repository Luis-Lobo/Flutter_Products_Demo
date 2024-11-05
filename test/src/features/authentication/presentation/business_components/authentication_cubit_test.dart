import 'dart:io';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_products_demo/src/features/authentication/data/authentication_repository.dart';
import 'package:flutter_products_demo/src/features/authentication/domain/use_cases/authentication_use_case.dart';
import 'package:flutter_products_demo/src/features/authentication/domain/use_cases/authentication_use_case_impl.dart';
import 'package:flutter_products_demo/src/features/authentication/presentations/components/business_components/authentication_cubit.dart';
import 'package:flutter_products_demo/src/features/authentication/presentations/components/business_components/authentication_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../../../../fixtures/model_mock.dart';
import '../../domain/use_cases/authentication_use_case_test.mocks.dart';

 @GenerateMocks([], customMocks: [
  MockSpec<AuthenticationUseCase>(as: #AuthenticationUseCaseMock),
  MockSpec<AuthenticationRepository>(as: #AutenticationRepositoryMock),
  MockSpec<BuildContext>(as: #MockBuildContext),
])

void main() {

  final repository = AutenticationRepositoryMock();
  final useCase = AuthenticationUseCaseImpl(repository: repository);
  final userModel = ModelMock.userModel;
  final context = MockBuildContext();

  const String email = 'email';
  const String password = 'password';
  const String name = 'name';
  final File image = File('lib/src/core/assets/images/marketing.jpg');
  blocTest<AuthenticationCubit, AuthenticationState>(
    'Test registerUser method when is success. It emits loading and success states.',
    build: () {
      when(useCase.registerUser(
        name: name,
        email: email,
        password: password,
        image: image,
      )).thenAnswer((_) async => Future.value());
      return AuthenticationCubit(useCase: useCase);
    },
    act: (cubit) => cubit.registerUser(
      name: name,
      email: email,
      password: password,
      image: image,
    ),
    expect: () => [
      AuthenticationState.initial().copyWith(uiState: AuthenticationUIState.loading),
      AuthenticationState.initial().copyWith(
        uiState: AuthenticationUIState.success,
        registerSucess: true,
        loginSucess: true,
      ),
    ],
  );

  blocTest<AuthenticationCubit, AuthenticationState>(
    'Test registerUser method when fails. It emits loading and error states.',
    build: () {
      when(useCase.registerUser(
        name: name,
        email: email,
        password: password,
        image: image,
      )).thenThrow(Exception('Registration failed'));
      return AuthenticationCubit(useCase: useCase);
    },
    act: (cubit) => cubit.registerUser(
        name: name,
        email: email,
        password: password,
        image: image,
    ),
    expect: () => [
      AuthenticationState.initial().copyWith(uiState: AuthenticationUIState.loading),
      AuthenticationState.initial().copyWith(
        uiState: AuthenticationUIState.error,
        registerErrorMessage: 'Exception: Registration failed',
      ),
    ],
  );

    blocTest<AuthenticationCubit, AuthenticationState>(
    'Test getUser method when is successful. It emits loading and sucess state.',
    build: () {
      when(useCase.getUser()).thenAnswer((_) async => userModel);
      return AuthenticationCubit(useCase: useCase);
    },
    act: (cubit) => cubit.getUser(),
    expect: () => [
      AuthenticationState.initial().copyWith(uiState: AuthenticationUIState.loading),
      AuthenticationState.initial().copyWith(uiState: AuthenticationUIState.success, userModel: userModel),
    ],
  );

  blocTest<AuthenticationCubit, AuthenticationState>(
    'Test getUser when fails. It emits loading and error state.',
    build: () {
      when(useCase.getUser()).thenThrow(Exception('Failed to fetch user'));
      return AuthenticationCubit(useCase: useCase);
    },
    act: (cubit) => cubit.getUser(),
    expect: () => [
      AuthenticationState.initial().copyWith(uiState: AuthenticationUIState.loading),
      AuthenticationState.initial().copyWith(uiState: AuthenticationUIState.error),
    ],
  );

    blocTest<AuthenticationCubit, AuthenticationState>(
    'Test login method when is sucessful. It emits loading and success states',
    build: () {
      when(useCase.login(email: email, password: password))
          .thenAnswer((_) async => Future.value());
      return AuthenticationCubit(useCase: useCase);
    },
    act: (cubit) => cubit.login(email: email, password:password),
    expect: () => [
      AuthenticationState.initial().copyWith(uiState: AuthenticationUIState.loading),
      AuthenticationState.initial().copyWith(uiState: AuthenticationUIState.success, loginSucess: true),
    ],
  );

  blocTest<AuthenticationCubit, AuthenticationState>(
    'Test login method when fails. It emits loading and error state.',
    build: () {
      when(useCase.login(email: email, password: password))
          .thenThrow(Exception('Login failed'));
      return AuthenticationCubit(useCase: useCase);
    },
    act: (cubit) => cubit.login(email: email, password: password),
    expect: () => [
      AuthenticationState.initial().copyWith(uiState: AuthenticationUIState.loading),
      AuthenticationState.initial().copyWith(
        uiState: AuthenticationUIState.error,
        loginErrorMessage: 'Exception: Login failed',
      ),
    ],
  );
  blocTest<AuthenticationCubit, AuthenticationState>(
    'Test logout method when is sucessful. It emits loading and resets login success state.',
    build: () {
      when(useCase.logout(context)).thenAnswer((_) async => Future.value());
      return AuthenticationCubit(useCase: useCase);
    },
    act: (cubit) => cubit.logout(context),
    expect: () => [
      AuthenticationState.initial().copyWith(uiState: AuthenticationUIState.loading, loginSucess: false),
    ],
  );

  blocTest<AuthenticationCubit, AuthenticationState>(
    'Test logout when fails. It emits loading and error state',
    build: () {
      when(useCase.logout(context)).thenThrow(Exception('Logout failed'));
      return AuthenticationCubit(useCase: useCase);
    },
    act: (cubit) => cubit.logout(context),
    expect: () => [
      AuthenticationState.initial().copyWith(uiState: AuthenticationUIState.loading),
      AuthenticationState.initial().copyWith(uiState: AuthenticationUIState.error),
    ],
  );
}
