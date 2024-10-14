import 'package:flutter/material.dart';
import 'package:flutter_products_demo/src/core/theme/application_colors.dart';
import 'package:flutter_products_demo/src/features/products/domain/models/product_model.dart';
import 'package:flutter_products_demo/src/features/products/presentations/components/product_rich_text_info.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProductCardDetails extends StatelessWidget {
  final ProductModel productModel;
  final GestureTapCallback? onTap;

  const ProductCardDetails({
    super.key,
    required this.productModel,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: onTap,
      child: Card(
        color: ApplicationColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  productModel.title,
                  textAlign: TextAlign.center,
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                    color: Colors.grey,
                  ),
                )),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Image.network(
                productModel.image,
                height: 200,
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
            ProductRichTextInfo(title: l10n.description, data: productModel.description),
            const SizedBox(height: 4.0),
            ProductRichTextInfo(title: l10n.category, data: productModel.category),
            const SizedBox(height: 4.0),
            ProductRichTextInfo(title: l10n.price, data: productModel.price.toString()),
          ],
        ),
      ),
    );
  }
}
