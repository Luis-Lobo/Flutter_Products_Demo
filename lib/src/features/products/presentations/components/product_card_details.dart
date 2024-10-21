import 'package:flutter/material.dart';
import 'package:flutter_products_demo/src/core/theme/application_colors.dart';
import 'package:flutter_products_demo/src/core/theme/application_styles_constants.dart';
import 'package:flutter_products_demo/src/features/products/domain/models/product_model.dart';
import 'package:flutter_products_demo/src/features/products/presentations/components/product_rich_text_info.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProductCardDetails extends StatelessWidget {
  final ProductModel productModel;

  const ProductCardDetails({
    super.key,
    required this.productModel,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Card(
      color: ApplicationColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ApplicationStylesConstants.spacing16Sp),
      ),
      child: Column(
        children: [
          Image.network(
            productModel.image,
            height: height * 0.5,
            width: width,
            fit: BoxFit.fitHeight,
          ),
          ProductRichTextInfo(title: l10n.priceSymbol, data: productModel.price.toString(), alignment: Alignment.center,),          
          const SizedBox(height: ApplicationStylesConstants.spacing32Sp),
          ProductRichTextInfo(
            title: l10n.category,
            data: productModel.category,
          ),
          const SizedBox(height: ApplicationStylesConstants.spacing4Sp),
          ProductRichTextInfo(title: l10n.description, data: productModel.description),
        ],
      ),
    );
  }
}
