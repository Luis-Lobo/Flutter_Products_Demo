import 'package:flutter/material.dart';
import 'package:flutter_products_demo/src/core/theme/application_colors.dart';
import 'package:flutter_products_demo/src/core/theme/application_styles_constants.dart';

class ProductsBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final String? subtitle;
  final VoidCallback? onPressedReturnToHome;
  final VoidCallback? onPressedPurchase;
  final VoidCallback? onPressedShare;

  const ProductsBar({
    super.key,
    this.title,
    this.subtitle,
    this.onPressedReturnToHome,
    this.onPressedPurchase,
    this.onPressedShare,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new),
        onPressed: onPressedReturnToHome,
      ),
      title: Row(
        children: [
          const SizedBox(width: ApplicationStylesConstants.spacing10Sp),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  subtitle ?? '',
                  textAlign: TextAlign.left,
                  style: textTheme.titleLarge?.copyWith(
                    color: Colors.green,
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
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
