import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_products_demo/src/core/config/app_config_cubit.dart';

class LanguageButton extends StatelessWidget {
  final String label;
  final String langCode;

  const LanguageButton({required this.label, required this.langCode});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => context.read<AppConfigCubit>().changeLanguage(langCode),
      child: Text(
        label,
        style: TextStyle(
          color: Colors.white,
          fontWeight: Localizations.localeOf(context).languageCode == langCode
              ? FontWeight.bold
              : FontWeight.normal,
        ),
      ),
    );
  }
}