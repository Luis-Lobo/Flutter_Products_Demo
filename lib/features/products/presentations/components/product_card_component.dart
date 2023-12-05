import 'package:flutter/material.dart';
import 'package:flutter_products_demo/features/products/domain/models/product_model.dart';

class ProductCardComponent extends StatelessWidget {
  final ProductModel productModel;
  final GestureTapCallback? onTap;

  const ProductCardComponent({
    super.key,
    required this.productModel,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Text(
            productModel.title,
            style: textTheme.titleMedium
                ?.copyWith(fontWeight: FontWeight.w400, color: Colors.red),
          ),
          const SizedBox(height: 4),
          Text(
            productModel.category,
            style: textTheme.titleMedium
                ?.copyWith(fontWeight: FontWeight.w400, color: Colors.green),
          ),
          const SizedBox(height: 4),
          Text(
            productModel.description,
            style: textTheme.titleMedium
                ?.copyWith(fontWeight: FontWeight.w400, color: Colors.yellow),
          ),
          const SizedBox(height: 4),
          Text(
            productModel.price.toString(),
            style: textTheme.titleMedium
                ?.copyWith(fontWeight: FontWeight.w400, color: Colors.blue),
          ),
        ],
      ),
    );
  }
}
