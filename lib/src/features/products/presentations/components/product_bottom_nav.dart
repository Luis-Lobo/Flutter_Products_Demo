import 'package:flutter/material.dart';
import 'package:flutter_products_demo/src/core/theme/application_colors.dart';

class ProductBottomNav extends StatelessWidget {
  final IconData icon;
  final String title;
  final void Function()? onTap;

  const ProductBottomNav({
    required this.icon, 
    required this.title,
    this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: ApplicationColors.white),
          Text(title),
        ],
      ), 
    );
  }
}
