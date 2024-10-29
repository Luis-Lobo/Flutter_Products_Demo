import 'package:flutter/material.dart';
import 'package:flutter_products_demo/src/core/theme/application_colors.dart';

class ProductBottomNav extends StatelessWidget {
  final IconData icon;
  final String title;
  final void Function()? onTap;

  const ProductBottomNav({required this.icon, required this.title, this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: ApplicationColors.black36),
          Text(
            title,
            style: textTheme.titleLarge?.copyWith(
              color: ApplicationColors.black36,
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
