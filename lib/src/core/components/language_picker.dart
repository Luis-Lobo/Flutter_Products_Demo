import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_products_demo/src/core/config/app_config_cubit.dart';
import 'package:flutter_products_demo/src/core/config/app_config_state.dart';

class LanguagePicker extends StatelessWidget {
  const LanguagePicker({super.key});

  Widget _buildFlagButton(BuildContext context, String flagEmoji,
      String langCode, bool isSelected) {
    return GestureDetector(
      onTap: () {
        context.read<AppConfigCubit>().changeLanguage(langCode);
      },
      child: Container(
        padding: const EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: isSelected
              ? Border.all(color: Colors.white, width: 2.0)
              : Border.all(color: Colors.transparent, width: 2.0),
        ),
        child: Text(
          flagEmoji,
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppConfigCubit, AppConfigState>(
      builder: (context, state) {
        final currentLanguageCode = state.locale.languageCode;

        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildFlagButton(
              context,
              '🇺🇸',
              'en',
              currentLanguageCode == 'en',
            ),
            const SizedBox(width: 8.0),
            _buildFlagButton(
              context,
              '🇧🇷',
              'pt',
              currentLanguageCode == 'pt',
            ),
            const SizedBox(width: 8.0),
            _buildFlagButton(
              context,
              '🇫🇷',
              'fr',
              currentLanguageCode == 'fr',
            ),
          ],
        );
      },
    );
  }
}
