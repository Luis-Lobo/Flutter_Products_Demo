import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_products_demo/src/core/factories/cubit_factories.dart';
import 'package:flutter_products_demo/src/features/products/presentations/bussiness_components/products_cubit.dart';
import 'package:flutter_products_demo/src/features/products/presentations/bussiness_components/products_state.dart';
import 'package:flutter_products_demo/src/features/products/presentations/components/product_card_details.dart';
import 'package:flutter_products_demo/src/features/products/presentations/components/product_card_home.dart';
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
  _l10n =  AppLocalizations.of(context)!;
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
              appBar:  ProductsBar(
                icon: Icons.draw,
                title: _l10n.name,
                subtitle: "products",
              ),
              body: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        primary: false,
                        itemCount: state.products.length,
                        itemBuilder: (context, index) {
                          final product = state.products.elementAt(index);
                          return Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: ProductCardHome(
                                productModel: product, onTap: () => context.go('/product_details', extra: product),),
                          );
                        },
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
