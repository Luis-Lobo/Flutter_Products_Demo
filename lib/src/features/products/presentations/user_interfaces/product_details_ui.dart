import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_products_demo/src/core/components/product_button.dart';
import 'package:flutter_products_demo/src/core/theme/application_colors.dart';
import 'package:flutter_products_demo/src/core/theme/application_styles_constants.dart';
import 'package:flutter_products_demo/src/features/products/domain/models/product_model.dart';
import 'package:flutter_products_demo/src/features/products/presentations/bussiness_components/products_cubit.dart';
import 'package:flutter_products_demo/src/features/products/presentations/bussiness_components/products_state.dart';
import 'package:flutter_products_demo/src/features/products/presentations/components/product_card_details.dart';
import 'package:flutter_products_demo/src/features/products/presentations/components/product_comments.dart';
import 'package:flutter_products_demo/src/features/products/presentations/components/product_snack_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_products_demo/src/features/products/presentations/components/products_bar.dart';

class ProductDetailsUI extends StatefulWidget {
  final ProductModel productModel;

  const ProductDetailsUI({required this.productModel, super.key});

  @override
  State<ProductDetailsUI> createState() => _ProductDetailsUIState();
}

class _ProductDetailsUIState extends State<ProductDetailsUI> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    final height = MediaQuery.of(context).size.height;
    final cubit = context.read<ProductsCubit>();
    return BlocConsumer<ProductsCubit, ProductsState>(listener: (context, currentState) {
      if (currentState.addProductInCartList == true) {
        ProductSnackBar.showAdditionSnackBar(context: context, message: l10n.addToCart);
        cubit.resetStatesSnackBar();
      }
    }, builder: (context, state) {
      return Scaffold(
        appBar: ProductsBar(
          title: widget.productModel.title,
          onPressedReturnToHome: () => context.go('/'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ProductCardDetails(
                  productModel: widget.productModel,
                ),
                const SizedBox(height: ApplicationStylesConstants.spacing16Sp),
                Text(
                  l10n.comments,
                  style: textTheme.titleLarge?.copyWith(
                    color: ApplicationColors.black36,
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: ApplicationStylesConstants.spacing16Sp),
                const ProductComments(
                  userImage: 'https://via.placeholder.com/150',
                  comment: "Neque porro quisquam est qui dolorem...",
                  rating: 4.5,
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Builder(builder: (context) {
          return SafeArea(
            child: Container(
              height: height * 0.06,
              color: ApplicationColors.red,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ProductButton(
                  textButton: l10n.add,
                  onPressed: () => cubit.addToCart(product: widget.productModel, cartList: state.cartList),
                ),
              ),
            ),
          );
        }),
      );
    });
  }
}
