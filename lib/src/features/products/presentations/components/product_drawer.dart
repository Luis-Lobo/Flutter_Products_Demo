import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_products_demo/src/core/theme/application_colors.dart';
import 'package:flutter_products_demo/src/core/theme/application_styles_constants.dart';
import 'package:go_router/go_router.dart';

class ProductDrawer extends StatelessWidget {
  final GestureTapCallback? onLogoutTap;

  const ProductDrawer({
    this.onLogoutTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    return Drawer(
      backgroundColor: ApplicationColors.grey700,
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
                child: ListView(
              shrinkWrap: false,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              children: [
                const SizedBox(height: ApplicationStylesConstants.spacing16Sp),
                ListTile(
                  title: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: ApplicationColors.white,
                        width: 4.0,
                      ),
                    ),
                    child: const CircleAvatar(
                      backgroundColor: ApplicationColors.darkBlue,
                      radius: 28,
                      child: Icon(Icons.person),
                    ),
                  ),
                ),
                ListTile(
                  title: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: ApplicationStylesConstants.spacing4Sp),
                      child: Text(
                        "user.name",
                        style: textTheme.titleLarge?.copyWith(color: ApplicationColors.white),
                      ),
                    ),
                  ),
                ),
                const Divider(
                  color: ApplicationColors.white,
                  indent: 16,
                  endIndent: 16,
                ),
                ListTile(
                  leading: const Icon(
                    Icons.keyboard_return,
                    color: ApplicationColors.white,
                    size: 24,
                  ),
                  title: Text(
                    l10n.logout,
                    style: textTheme.titleMedium?.copyWith(
                      color: ApplicationColors.white,
                    ),
                  ),
                  onTap: ()=> context.go('/'),
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
