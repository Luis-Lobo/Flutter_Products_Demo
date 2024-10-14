import 'package:flutter/material.dart';
import 'package:flutter_products_demo/src/core/theme/application_colors.dart';
import 'package:flutter_products_demo/src/core/theme/application_styles_constants.dart';
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
          borderRadius: BorderRadius.circular(ApplicationStylesConstants.spacing36Sp),
        ),
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.symmetric(vertical: ApplicationStylesConstants.spacing36Sp),
                child: Text(
                  productModel.title,
                  textAlign: TextAlign.center,
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: ApplicationStylesConstants.spacing24Sp,
                    color: Colors.grey,
                  ),
                )),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: ApplicationStylesConstants.spacing8Sp,),
              child: Image.network(
                productModel.image,
                height: ApplicationStylesConstants.spacing200Sp,
                width: ApplicationStylesConstants.spacing100Sp,
                fit: BoxFit.cover,
              ),
            ),
            ProductRichTextInfo(title: l10n.description, data: productModel.description),
            const SizedBox(height: ApplicationStylesConstants.spacing4Sp),
            ProductRichTextInfo(title: l10n.category, data: productModel.category),
            const SizedBox(height: ApplicationStylesConstants.spacing4Sp),
            ProductRichTextInfo(title: l10n.price, data: productModel.price.toString()),
          ],
        ),
      ),
    );
  }
}
