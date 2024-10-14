import 'package:flutter/material.dart';
import 'package:flutter_products_demo/src/core/theme/application_styles_constants.dart';

class ProductsBar extends StatelessWidget implements PreferredSizeWidget {
  final IconData icon;
  final String? title;
  final String? subtitle;
  final bool hideDefaultAction;
  final VoidCallback? onPressed;

  const ProductsBar({
    super.key,
    required this.icon,
    this.title,
    this.subtitle,
    this.hideDefaultAction = false,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    double fontSize = MediaQuery.of(context).size.width > 360 ? 20 : 14;
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new),
        onPressed: onPressed,
      ),
      title: Row(
        children: [
          Icon(
            icon,
            size: 24,
          ),
          const SizedBox(width: ApplicationStylesConstants.spacing10Sp),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title ?? '',
                  textAlign: TextAlign.left,
                  style: textTheme.titleLarge?.copyWith(
                    color: Colors.red,
                    fontWeight: FontWeight.w700,
                    fontSize: fontSize,
                  ),
                ),
                const SizedBox(width: 8),
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
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(ApplicationStylesConstants.spacing60Sp);
}
