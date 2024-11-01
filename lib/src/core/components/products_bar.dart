import 'package:flutter/material.dart';
import 'package:flutter_products_demo/src/core/theme/application_colors.dart';
import 'package:flutter_products_demo/src/core/theme/application_styles_constants.dart';

class ProductsBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final VoidCallback? onPop;
  final VoidCallback? onPressedPurchase;
  final VoidCallback? onPressedShare;

  const ProductsBar({
    super.key,
    this.title,
    this.onPop,
    this.onPressedPurchase,
    this.onPressedShare,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new),
        onPressed: onPop,
      ),
      title: Row(
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title ?? '',
                  textAlign: TextAlign.justify,
                  maxLines: 2,
                  style: textTheme.titleLarge?.copyWith(
                    color: ApplicationColors.black36,
                    fontWeight: FontWeight.w400,
                    fontSize: 22,
                  ),
                ),
              ],
            ),
          ),
        /*  IconButton(
            icon: const Icon(
              Icons.shopping_cart,
              size: 24,
            ),
            color: ApplicationColors.black36,
            onPressed: onPressedPurchase,
          ),
          IconButton(
            icon: const Icon(
              Icons.share,
              size: 24,
            ),
            color: ApplicationColors.black36,
            onPressed: onPressedShare, 
          ), */
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(ApplicationStylesConstants.spacing60Sp);
}
