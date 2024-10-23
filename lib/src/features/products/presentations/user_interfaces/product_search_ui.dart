import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_products_demo/src/core/components/product_text_form_field.dart';
import 'package:flutter_products_demo/src/features/products/presentations/bussiness_components/products_cubit.dart';
import 'package:flutter_products_demo/src/features/products/presentations/bussiness_components/products_state.dart';
import 'package:flutter_products_demo/src/features/products/presentations/components/product_card_home.dart';
import 'package:flutter_products_demo/src/features/products/presentations/components/product_snack_bar.dart';
import 'package:go_router/go_router.dart';

class ProductSearchUI extends HookWidget {
  const ProductSearchUI({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProductsCubit>();
    final l10n = AppLocalizations.of(context)!;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return BlocConsumer<ProductsCubit, ProductsState>(
      listener: (context, currentState) {
      if (currentState.removeProductInCartList == true) {
        ProductSnackBar.showRemoveSnackBar(context: context, message: l10n.removeToCard);
        cubit.resetStatesSnackBar();
      }
    }, builder: (context, state) {
      return Flex(
        direction: Axis.vertical,
        children: [
          SizedBox(height: height * 0.05),
          ProductTextFormField(
            prefixIcon: const Icon(Icons.search),
            onChanged: (value) {
              cubit.filterProduct(query: value);
            },
          ),
          SizedBox(height: height * 0.05),
          SizedBox(
                  height: height * 0.55,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.filterList.length,
                      itemBuilder: (BuildContext ctx, index) {
                        final product = state.filterList.elementAt(index);
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: width * 0.7,
                            child: ProductCardHome(
                              productModel: product,
                              onTap: () => context.go('/productDetails', extra: product),
                              addToPurchaseList: () => cubit.addToCart(product: product, cartList: state.cartList),
                            ),
                          ),
                        );
                      }),
                ),
        ],
      );
    });
  }
}
