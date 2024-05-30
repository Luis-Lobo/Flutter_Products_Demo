import 'package:flutter/material.dart';
import 'package:flutter_products_demo/src/core/theme/application_colors.dart';
import 'package:flutter_products_demo/src/features/products/domain/models/product_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProductCardHome extends StatelessWidget {
  final ProductModel productModel;
  final GestureTapCallback? onTap;

  const ProductCardHome({
    super.key,
    required this.productModel,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    final height = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: height * 0.4,
              child: Image.network(
                productModel.image,
                fit: BoxFit.fill,
              ),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  productModel.title,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                )),
            Center(
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: l10n.priceSymbol,
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    TextSpan(
                      text: productModel.price.toString(),
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700, 
                        fontSize: 24,
                        color: ApplicationColors.red),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
