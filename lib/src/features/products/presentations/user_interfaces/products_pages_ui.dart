import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_products_demo/src/core/theme/application_colors.dart';
import 'package:flutter_products_demo/src/features/products/presentations/bussiness_components/products_cubit.dart';
import 'package:flutter_products_demo/src/features/products/presentations/bussiness_components/products_state.dart';
import 'package:flutter_products_demo/src/features/products/presentations/components/product_bottom_nav.dart';
import 'package:flutter_products_demo/src/features/products/presentations/components/product_drawer.dart';
import 'package:flutter_products_demo/src/features/products/presentations/user_interfaces/product_cart_ui.dart';
import 'package:flutter_products_demo/src/features/products/presentations/user_interfaces/product_search_ui.dart';
import 'package:flutter_products_demo/src/features/products/presentations/user_interfaces/products_home_ui.dart';

class ProductsPagesUI extends HookWidget {
  final ProductUIPages? page;

  ProductsPagesUI({this.page, super.key});

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProductsCubit>();
    final height = MediaQuery.of(context).size.height;
    final l10n = AppLocalizations.of(context)!;

    useEffect(() {
      cubit.initialize(
        page: page,
      );
      return null;
    }, const []);

    return BlocConsumer<ProductsCubit, ProductsState>(
      listener: (_, currentState) {},
      builder: (context, state) {
        return Scaffold(
          key: _scaffoldKey,
          body: Padding(
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (state.isHomePage) const ProductsHomeUI(),
                  if (state.isCartPage) const ProductCardUI(),
                  if (state.isSearchPage) const ProductSearchUI(),
                ],
              ),
            ),
          ),
          drawer: const ProductDrawer(),
          bottomNavigationBar: Builder(builder: (context) {
            return SafeArea(
              child: Container(
                height: height * 0.06,
                decoration: const BoxDecoration(
                  color: ApplicationColors.red,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ProductBottomNav(
                      icon: Icons.home,
                      title: l10n.shop,
                      onTap: () => cubit.initialize(),
                    ),
                    ProductBottomNav(
                      icon: Icons.search,
                      title: l10n.search,
                      onTap: () => cubit.goToSearchPage(),
                    ),
                    ProductBottomNav(
                      icon: Icons.shopping_cart,
                      title: l10n.purchase,
                      onTap: () => cubit.goToCartPage(),
                    ),
                    ProductBottomNav(
                      icon: Icons.person,
                      title: l10n.profile,
                      onTap: _scaffoldKey.currentState!.openDrawer,
                    ),
                  ],
                ),
              ),
            );
          }),
        );
      },
    );
  }
}
