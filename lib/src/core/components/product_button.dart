import 'package:flutter/material.dart';
import 'package:flutter_products_demo/src/core/theme/application_colors.dart';

class ProductButton extends StatelessWidget {
  final String textButton;
  final BorderRadiusGeometry borderRadius;
  final VoidCallback? onPressed;

  const ProductButton({
    required this.textButton, 
    this.borderRadius = BorderRadius.zero, 
    this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: ApplicationColors.black36,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius,
        ),
      ),
      onPressed: onPressed,
      child: Text(
        textButton,
        style: textTheme.titleLarge?.copyWith(
          color: ApplicationColors.white,
          fontWeight: FontWeight.w700,
          fontSize: 24,
        ),
      ),
    );
  }
}
