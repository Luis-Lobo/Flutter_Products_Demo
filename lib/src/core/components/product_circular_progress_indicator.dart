import 'package:flutter/material.dart';
import 'package:flutter_products_demo/src/core/theme/application_colors.dart';

class ProductCircularProgressIndicator extends StatefulWidget {
  const ProductCircularProgressIndicator({super.key});

  @override
  State<ProductCircularProgressIndicator> createState() => _ProductCircularProgressIndicatorState();
}

class _ProductCircularProgressIndicatorState extends State<ProductCircularProgressIndicator> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: ApplicationColors.red,
        backgroundColor: ApplicationColors.black36,
      ),
    );
  }
}
