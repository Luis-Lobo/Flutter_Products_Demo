import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_products_demo/src/core/theme/application_colors.dart';
import 'package:flutter_products_demo/src/features/products/presentations/bussiness_components/products_cubit.dart';
import 'package:flutter_products_demo/src/features/products/presentations/bussiness_components/products_state.dart';
import 'package:flutter_products_demo/src/features/products/presentations/components/product_bottom_nav.dart';
import 'package:flutter_products_demo/src/features/products/presentations/user_interfaces/product_cart_page_ui.dart';
import 'package:flutter_products_demo/src/features/products/presentations/user_interfaces/products_home_ui.dart';

class ProductsPagesUI extends HookWidget {
  final ProductUIPages? page;

  const ProductsPagesUI({this.page, super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProductsCubit>();
    final height = MediaQuery.of(context).size.height;

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
          body: Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (state.isHomePage) const ProductsHomeUI(),
                if (state.isCartPage) const ProductCardPage(),
              ],
            ),
          ),
        ),
          bottomNavigationBar: SafeArea(
                child: Container(
                  height: height * 0.04,
                  decoration: const BoxDecoration(
                    color: ApplicationColors.red,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ProductBottomNav(
                        icon: Icons.home,
                        onTap:() {},
                      ),
                      ProductBottomNav(
                        icon: Icons.search,
                        onTap:() {},
                      ),
                      ProductBottomNav(
                        icon: Icons.add_box_rounded,
                        onTap:() {},
                      ),
                      ProductBottomNav(
                        icon: Icons.shopping_cart,
                        onTap:() {},
                      ),
                      ProductBottomNav(
                        icon: Icons.person,
                        onTap:() {},
                      ),
                    ],
                  ),
                ),
              ),
        );
      },
    );
  }
}
