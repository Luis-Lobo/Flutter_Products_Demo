import 'package:flutter/material.dart';
import 'package:flutter_products_demo/src/core/theme/application_colors.dart';

class ProductBottomNav extends StatelessWidget {
  const ProductBottomNav({
    this.icon,
    this.onTap,
    super.key});

  final void Function()? onTap;
  final IconData? icon;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 36,
        width: 36,
        child: Icon(icon, color: ApplicationColors.white),
      ),
    );
  }
}
