import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_products_demo/src/core/theme/application_colors.dart';

class ProductDrawer extends StatelessWidget {
 // final UserModel user;
 // final PackageInfo? packageInfo;
  final GestureTapCallback? onLogoutTap;

  const ProductDrawer({
 //   required this.user,
    this.onLogoutTap,
 //   this.packageInfo,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context)!;
    return Drawer(
      backgroundColor: ApplicationColors.darkBlue,
      child: Column(
        children: [
          DrawerHeader(
            duration: const Duration(milliseconds: 1000),
            decoration: BoxDecoration(
              border: Border(
                bottom: Divider.createBorderSide(
                  context,
                  color: ApplicationColors.white,
                ),
              ),
            ),
            child: Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              columnWidths: const {
                0: FractionColumnWidth(0.2),
                1: FractionColumnWidth(0.8)
              },
              children: [
                TableRow(children: [
                  const Icon(Icons.person, size: 24),
                  Text(
                    "nome",
                    style: textTheme.headlineSmall?.copyWith(
                      color: ApplicationColors.white,
                    ),
                  ),
                ]),
                TableRow(
                  children: [
                    const SizedBox(width: 24),
                    Text(
                      "texto",
                      style: textTheme.titleMedium?.copyWith(
                        color: ApplicationColors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            columnWidths: const {
              0: FractionColumnWidth(0.2),
              1: FractionColumnWidth(0.8)
            },
            children: [
              TableRow(
                children: [
                  const Icon(
                    Icons.assignment,
                    size: 24,
                  ),
                  InkWell(
                    child: Text(
                      "nome",
                      style: textTheme.titleMedium?.copyWith(
                        color: ApplicationColors.white,
                      ),
                    ),
                    onTap: () {
                      
                    },
                  ),
                ],
              ),
              TableRow(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Icon(
                      Icons.keyboard_return,
                      size: 24,
                    ),
                  ),
             /*     InkWell(
                    onTap: onLogoutTap,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        l10n.homeDrawerItemExit,
                        style: textTheme.titleMedium?.copyWith(
                          color: ApplicationColors.white,
                        ),
                      ),
                    ),
                  ), */
                ],
              ),
            ],
          ),
          const Spacer(),
    /*      Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: Platform.isAndroid
                  ? const EdgeInsets.all(8.0)
                  : const EdgeInsets.all(24.0),
              child: Text(
                _appInfo,
                style: textTheme.bodySmall?.copyWith(
                  color: ApplicationColors.white,
                ),
              ),
            ),
          ), */
        ],
      ),
    );
  }

 /* String get _appInfo => packageInfo != null
      ? '${packageInfo?.version}+${packageInfo?.buildNumber}'
      : ''; */
}
