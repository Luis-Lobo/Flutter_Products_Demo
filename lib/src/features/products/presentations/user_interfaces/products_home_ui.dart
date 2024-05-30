import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_products_demo/src/core/factories/cubit_factories.dart';
import 'package:flutter_products_demo/src/core/theme/application_colors.dart';
import 'package:flutter_products_demo/src/features/products/presentations/bussiness_components/products_cubit.dart';
import 'package:flutter_products_demo/src/features/products/presentations/bussiness_components/products_state.dart';
import 'package:flutter_products_demo/src/features/products/presentations/components/product_bottom_nav.dart';
import 'package:flutter_products_demo/src/features/products/presentations/components/product_card_home.dart';
import 'package:flutter_products_demo/src/features/products/presentations/components/product_drawer.dart';
import 'package:flutter_products_demo/src/features/products/presentations/components/products_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class ProductsHomeUI extends StatefulWidget {
  const ProductsHomeUI({super.key});

  @override
  State<ProductsHomeUI> createState() => _ProductsHomeUIState();
}

class _ProductsHomeUIState extends State<ProductsHomeUI> {
  final ProductsCubit _cubit = CubitFactories.productsCubit;
  late AppLocalizations _l10n;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _cubit.getProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    _l10n = AppLocalizations.of(context)!;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return BlocBuilder<ProductsCubit, ProductsState>(
        bloc: _cubit,
        builder: (context, state) {
          if (state is ProductsErrorState) {
            return Scaffold(
              appBar: const ProductsBar(
                title: "Error",
                icon: Icons.credit_card,
              ),
              body: Center(
                child: Text(state.message),
              ),
            );
          }
          if (state is ProductsSuccessState) {
            return Scaffold(
              backgroundColor: ApplicationColors.grey400,
            /*  appBar: ProductsBar(
                icon: Icons.draw,
                title: _l10n.name,
                subtitle: "products",
              ),*/
              drawer: const ProductDrawer(),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: height * 0.3,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("lib/src/core/assets/marketing.jpg"),
                          fit: BoxFit.fitWidth
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: SizedBox(
                        height: height * 0.55,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: state.products.length,
                            itemBuilder: (BuildContext ctx, index) {
                              final product = state.products.elementAt(index);
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  width: width * 0.7,
                                  child: ProductCardHome(
                                    productModel: product,
                                    onTap: () => context.go('/product_details', extra: product),
                                  ),
                                ),
                              );
                            }),
                      ),
                    ),
                  ],
                ),
              ),
              bottomNavigationBar: SafeArea(
                child: Container(
                  height: height * 0.04,
                  decoration: const BoxDecoration(
                    color: ApplicationColors.orange,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ProductBottomNav(
                        icon: Icons.home,
                      ),
                      ProductBottomNav(
                        icon: Icons.search,
                      ),
                      ProductBottomNav(
                        icon: Icons.add_box_rounded,
                      ),
                      ProductBottomNav(
                        icon: Icons.shopping_cart,
                      ),
                      ProductBottomNav(
                        icon: Icons.person,
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return const Scaffold(
              appBar: ProductsBar(
                title: "loading",
                icon: Icons.credit_card,
              ),
              body: CircularProgressIndicator(),
            );
          }
        });
  }
}
