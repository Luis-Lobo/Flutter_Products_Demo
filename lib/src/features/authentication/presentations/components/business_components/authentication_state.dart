import 'package:equatable/equatable.dart';
import 'package:flutter_products_demo/src/features/authentication/domain/model/user_model.dart';
import 'package:flutter_products_demo/src/features/products/domain/models/product_model.dart';

class AuthenticationState extends Equatable {
  final AuthenticationUIState uiState;
  final UserModel? userModel;

  factory AuthenticationState.initial() => const AuthenticationState(
        uiState: AuthenticationUIState.initial,
      );

  const AuthenticationState({
    required this.uiState,
    this.userModel,
  });

  AuthenticationState copyWith({
    AuthenticationUIState? uiState,
    UserModel? userModel,
  }) =>
      AuthenticationState(
        uiState: uiState ?? this.uiState,
        userModel: userModel ?? this.userModel,
      );

  @override
  List<Object?> get props => [
        uiState,
        userModel,
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
