import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_products_demo/src/core/config/app_config_state.dart';

class AppConfigCubit extends Cubit<AppConfigState> {
  AppConfigCubit() : super(AppConfigState.initial());

  void changeLanguage(String langCode) {
    emit(state.copyWith(locale: Locale(langCode)));
  }
}