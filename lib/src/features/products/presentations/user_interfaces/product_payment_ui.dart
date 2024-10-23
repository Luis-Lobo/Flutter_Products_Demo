import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_products_demo/src/core/components/product_text_form_field.dart';
import 'package:flutter_products_demo/src/core/theme/application_styles_constants.dart';
import 'package:flutter_products_demo/src/features/products/presentations/bussiness_components/products_cubit.dart';
import 'package:flutter_products_demo/src/features/products/presentations/bussiness_components/products_state.dart';
import 'package:flutter_products_demo/src/features/products/presentations/components/product_item_tile.dart';
import 'package:flutter_products_demo/src/features/products/presentations/components/product_snack_bar.dart';

class ProductPaymentUI extends HookWidget {
  const ProductPaymentUI({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProductsCubit>();
    final l10n = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    final height = MediaQuery.of(context).size.height;
    final formKey = GlobalKey();
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
            height: height * 0.7,
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
          SizedBox(
            child: Text(l10n.totalPurchasePrice),
          ),
          SizedBox(
            child: Text(state.totalPurchasePrice.toStringAsFixed(2)),
          ),
          Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ProductTextFormField(
                  hintText: l10n.cardNumber,
                  labelText: l10n.cardNumber,
                ),
                const SizedBox(height: ApplicationStylesConstants.spacing16Sp),
                ProductTextFormField(
                  hintText: l10n.cardHolderName,
                  labelText: l10n.cardHolderName,
                ),
                const SizedBox(height: ApplicationStylesConstants.spacing16Sp),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ProductTextFormField(
                        hintText: l10n.expirationDate,
                        labelText: l10n.expirationDate,
                      ),
                    ),
                    const SizedBox(width: ApplicationStylesConstants.spacing8Sp),
                    Expanded(
                      child: ProductTextFormField(
                        hintText: l10n.securityCode,
                        labelText: l10n.securityCode,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      );
    });
  }
}
