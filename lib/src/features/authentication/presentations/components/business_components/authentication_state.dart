import 'package:equatable/equatable.dart';
import 'package:flutter_products_demo/src/features/authentication/domain/model/user_model.dart';

class AuthenticationState extends Equatable {
  final AuthenticationUIState uiState;
  final bool registerSucess;
  final bool loginSucess;
  final String? registerErrorMessage;
  final String? loginErrorMessage;
  final UserModel? userModel;
  final bool recoverPasswordSucess;

  factory AuthenticationState.initial() => const AuthenticationState(
        uiState: AuthenticationUIState.initial,
      );

  const AuthenticationState({
    required this.uiState,
    this.registerSucess = false,
    this.loginSucess = false,
    this.registerErrorMessage,
    this.loginErrorMessage,
    this.userModel,
    this.recoverPasswordSucess = false,
  });

  AuthenticationState copyWith({
    AuthenticationUIState? uiState,
    bool? registerSucess,
    bool? loginSucess,
    String? registerErrorMessage,
    String? loginErrorMessage,
    UserModel? userModel,
    bool? recoverPasswordSucess,
  }) =>
      AuthenticationState(
        uiState: uiState ?? this.uiState,
        registerSucess: registerSucess ?? this.registerSucess,
        loginSucess: loginSucess ?? this.loginSucess,
        registerErrorMessage: registerErrorMessage ?? this.registerErrorMessage,
        loginErrorMessage: loginErrorMessage ?? this.loginErrorMessage,
        userModel: userModel ?? this.userModel,
        recoverPasswordSucess: recoverPasswordSucess ?? this.recoverPasswordSucess,
      );

  @override
  List<Object?> get props => [
        uiState,
        registerSucess,
        loginSucess,
        loginErrorMessage,
        userModel,
        recoverPasswordSucess,
      ];
}

enum AuthenticationUIState {
  initial,
  loading,
  success,
  error;

  bool get isSuccess => this == AuthenticationUIState.success;

  bool get hasError => this == AuthenticationUIState.error;

  bool get isLoading => this == AuthenticationUIState.loading || this == AuthenticationUIState.initial;
}
