import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_products_demo/src/core/components/product_button.dart';
import 'package:flutter_products_demo/src/core/theme/application_colors.dart';
import 'package:flutter_products_demo/src/core/theme/application_styles_constants.dart';
import 'package:flutter_products_demo/src/features/products/presentations/bussiness_components/products_cubit.dart';
import 'package:flutter_products_demo/src/features/products/presentations/bussiness_components/products_state.dart';
import 'package:flutter_products_demo/src/features/products/presentations/components/product_item_tile.dart';
import 'package:flutter_products_demo/src/features/products/presentations/components/product_snack_bar.dart';

class ProductCardUI extends HookWidget {
  const ProductCardUI({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProductsCubit>();
    final l10n = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    final height = MediaQuery.of(context).size.height;
    return BlocConsumer<ProductsCubit, ProductsState>(listener: (context, currentState) {
      if (currentState.removeProductInCartList == true) {
        ProductSnackBar.showRemoveSnackBar(context: context, message: l10n.removeToCard);
        cubit.resetStatesSnackBar();
      }
    }, builder: (context, state) {
      return Flex(
        direction: Axis.vertical,
        children: [
          SizedBox(
              height: height,
              child: state.cartList.isEmpty
                  ? Center(
                      child: Text(
                      l10n.shoppingCartEmpty,
                      style: textTheme.titleLarge?.copyWith(
                        color: ApplicationColors.black36,
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                      ),
                    ))
                  : Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          flex: 7,
                          child: ListView.builder(
                              itemCount: state.cartList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.only(top: ApplicationStylesConstants.spacing16Sp),
                                  child: ProductItemTile(
                                    productModel: state.cartList[index],
                                    remove: () => cubit.removeToCart(product: state.cartList[index], cartList: state.cartList),
                                  ),
                                );
                              }),
                        ),
                        Flexible(
                          flex: 2,
                          child: Card(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  l10n.totalPurchasePrice,
                                  style: textTheme.titleLarge?.copyWith(
                                    color: ApplicationColors.black36,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                              state.totalPurchasePrice.toStringAsFixed(2),
                              style: textTheme.titleLarge?.copyWith(
                                color: ApplicationColors.black36,
                                fontWeight: FontWeight.w700,
                                fontSize: 32,
                              ),
                            ),
                              ],
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 2,
                          child: ProductButton(
                            textButton: l10n.continuee,
                            borderRadius: BorderRadius.circular(16.0),
                            onPressed: () => cubit.goToPaymentPage(),
                          ),
                        )
                      ],
                    )),
        ],
      );
    });
  }
}
