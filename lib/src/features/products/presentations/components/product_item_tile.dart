import 'package:flutter/material.dart';
import 'package:flutter_products_demo/src/core/theme/application_colors.dart';
import 'package:flutter_products_demo/src/core/theme/application_styles_constants.dart';
import 'package:flutter_products_demo/src/features/products/domain/models/product_model.dart';

class ProductItemTile extends StatelessWidget {
  final ProductModel productModel;
  final VoidCallback? remove;

  const ProductItemTile({
    super.key,
    required this.productModel,
    this.remove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(ApplicationStylesConstants.spacing10Sp),
        border: Border.all(
          color: ApplicationColors.black
        )
      ),
      child: ListTile(
        leading: Image.network(productModel.image, width: 50, height: 50, fit: BoxFit.cover),
        title: Text(productModel.title),
        trailing: IconButton(
          icon: const Icon(Icons.delete_forever_rounded),
          color:  Colors.red,
          onPressed: remove,
        ),
      ),
    );
  }
  }
