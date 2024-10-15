import 'package:flutter/material.dart';
import 'package:flutter_products_demo/src/core/theme/application_colors.dart';
import 'package:flutter_products_demo/src/core/theme/application_styles_constants.dart';
import 'package:flutter_products_demo/src/features/products/domain/models/product_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProductCardHome extends StatelessWidget {
  final ProductModel productModel;
  final GestureTapCallback? onTap;
  final GestureTapCallback? addToPurchaseList;

  const ProductCardHome({
    super.key,
    required this.productModel,
    required this.onTap,
    required this.addToPurchaseList,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    final height = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: onTap,
      child: Card(
        color: ApplicationColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ApplicationStylesConstants.spacing8Sp),
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
                padding: const EdgeInsets.all(ApplicationStylesConstants.spacing16Sp),
                child: Text(
                  productModel.title,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: ApplicationColors.black,
                  ),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Center(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: l10n.priceSymbol,
                          style: textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w400,
                            color: ApplicationColors.black,
                          ),
                        ),
                        const WidgetSpan(child: SizedBox(width: ApplicationStylesConstants.spacing4Sp)),
                        TextSpan(
                          text: productModel.price.toString(),
                          style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700, fontSize: 24, color: ApplicationColors.red),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: addToPurchaseList,
                  child: Container(
                    width: 60,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                      border: Border.all(
                        color: ApplicationColors.black36,
                        width: 2.0,
                      ),
                      
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.add_shopping_cart,
                        color: ApplicationColors.black36,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
