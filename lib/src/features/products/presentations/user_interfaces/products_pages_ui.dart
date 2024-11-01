import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_products_demo/src/core/theme/application_colors.dart';
import 'package:flutter_products_demo/src/features/authentication/presentations/components/business_components/authentication_cubit.dart';
import 'package:flutter_products_demo/src/features/authentication/presentations/components/business_components/authentication_state.dart';
import 'package:flutter_products_demo/src/features/products/presentations/bussiness_components/products_cubit.dart';
import 'package:flutter_products_demo/src/features/products/presentations/bussiness_components/products_state.dart';
import 'package:flutter_products_demo/src/core/components/product_bottom_nav.dart';
import 'package:flutter_products_demo/src/core/components/product_drawer.dart';
import 'package:flutter_products_demo/src/features/products/presentations/user_interfaces/product_cart_ui.dart';
import 'package:flutter_products_demo/src/features/products/presentations/user_interfaces/product_payment_ui.dart';
import 'package:flutter_products_demo/src/features/products/presentations/user_interfaces/product_search_ui.dart';
import 'package:flutter_products_demo/src/features/products/presentations/user_interfaces/products_home_ui.dart';

class ProductsPagesUI extends HookWidget {
  final ProductUIPages? page;

  ProductsPagesUI({this.page, super.key});

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthenticationCubit>();
    final productCubit = context.read<ProductsCubit>();
    final height = MediaQuery.of(context).size.height;
    final l10n = AppLocalizations.of(context)!;

    useEffect(() {
      productCubit.initialize(
        page: page,
      );
      authCubit.getUser();
      return null;
    }, const []);

    return BlocConsumer<ProductsCubit, ProductsState>(
      listener: (_, currentState) {},
      builder: (context, state) {
        return Scaffold(
          key: _scaffoldKey,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (state.isHomePage) const ProductsHomeUI(),
                if (state.isCartPage) const ProductCardUI(),
                if (state.isSearchPage) const ProductSearchUI(),
                if (state.isPaymentPage) const ProductPaymentUI(),
              ],
            ),
          ),
          drawer: BlocBuilder<AuthenticationCubit, AuthenticationState>(builder: (context, state) {
            return ProductDrawer(
              userModel: state.userModel!,
              onLogoutTap: () => authCubit.logout(context),
            );
          }),
          bottomNavigationBar: Builder(builder: (context) {
            return SafeArea(
              child: Container(
                height: height * 0.08,
                decoration: const BoxDecoration(
                  color: ApplicationColors.red,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ProductBottomNav(
                      icon: Icons.home,
                      title: l10n.shop,
                      onTap: () => productCubit.initialize(),
                    ),
                    ProductBottomNav(
                      icon: Icons.search,
                      title: l10n.search,
                      onTap: () => productCubit.goToSearchPage(),
                    ),
                    ProductBottomNav(
                      icon: Icons.shopping_cart,
                      title: l10n.purchase,
                      onTap: () => productCubit.goToCartPage(),
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
