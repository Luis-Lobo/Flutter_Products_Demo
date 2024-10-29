import 'package:flutter/material.dart';
import 'package:flutter_products_demo/src/core/theme/application_colors.dart';

class ErrorMessage extends StatelessWidget {
  final String message;
  const ErrorMessage({required this.message, super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Text(
      message,
      style: textTheme.titleMedium?.copyWith(
        color: ApplicationColors.red,
        fontWeight: FontWeight.w400,
        fontSize: 16,
      ),
    );
  }
}
