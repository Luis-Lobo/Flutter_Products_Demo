import 'dart:ui';

class AppConfigState {
  final Locale locale;
  // Você pode adicionar 'themeMode' aqui no futuro!

  AppConfigState({required this.locale});

  factory AppConfigState.initial() => AppConfigState(locale: const Locale('en'));

  AppConfigState copyWith({Locale? locale}) {
    return AppConfigState(locale: locale ?? this.locale);
  }
}