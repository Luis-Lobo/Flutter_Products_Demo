import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_products_demo/src/core/theme/application_styles_constants.dart';
import 'package:flutter_products_demo/src/features/products/presentations/bussiness_components/products_cubit.dart';
import 'package:flutter_products_demo/src/features/products/presentations/bussiness_components/products_state.dart';
import 'package:flutter_products_demo/src/features/products/presentations/components/product_item_tile.dart';
import 'package:flutter_products_demo/src/features/products/presentations/components/product_snack_bar.dart';

class ProductCardPage extends HookWidget {
  const ProductCardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProductsCubit>();
    final l10n = AppLocalizations.of(context)!;
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
            height: height * 0.7,
            child: state.cartList.isEmpty
                ? const SizedBox()
                : ListView.builder(
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
        ],
      );
    });
  }
}
