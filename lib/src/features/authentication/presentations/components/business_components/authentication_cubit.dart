import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_products_demo/src/features/authentication/domain/use_cases/authentication_use_case.dart';
import 'package:flutter_products_demo/src/features/authentication/presentations/components/business_components/authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  final AuthenticationUseCase _useCase;

  AuthenticationCubit({
    required AuthenticationUseCase useCase,
  })  : _useCase = useCase,
        super(AuthenticationState.initial());

  void getUser() async {
    try {
      emit(state.copyWith(uiState: AuthenticationUIState.loading));

      final userModel = await _useCase.getUser();

      if (userModel == null) {
        emit(state.copyWith(uiState: AuthenticationUIState.error));
        return;
      }

      emit(state.copyWith(
        userModel: userModel,
      ));
    } catch (exception) {
       emit(state.copyWith(
        uiState: AuthenticationUIState.error,
      ));
    }
  }
}
