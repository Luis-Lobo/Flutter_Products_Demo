import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_products_demo/src/core/theme/application_styles_constants.dart';
import 'package:flutter_products_demo/src/features/products/presentations/bussiness_components/products_cubit.dart';
import 'package:flutter_products_demo/src/features/products/presentations/bussiness_components/products_state.dart';
import 'package:flutter_products_demo/src/features/products/presentations/components/product_card_home.dart';
import 'package:flutter_products_demo/src/features/products/presentations/components/product_carousel.dart';
import 'package:flutter_products_demo/src/features/products/presentations/components/product_snack_bar.dart';
import 'package:go_router/go_router.dart';

class ProductsHomeUI extends HookWidget {
  const ProductsHomeUI({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final cubit = context.read<ProductsCubit>();
    final l10n = AppLocalizations.of(context)!;
    final CarouselSliderController controller = CarouselSliderController();
    final ValueNotifier<int> currentUrl = ValueNotifier<int>(0);
    return BlocConsumer<ProductsCubit, ProductsState>(
      listener: (context, currentState) {
      if (currentState.addProductInCartList == true) {
        ProductSnackBar.showAdditionSnackBar(context: context, message: l10n.addToCart);
        cubit.resetStatesSnackBar();
      }
    }, builder: (context, state) {
      return Flex(
        direction: Axis.vertical,
        children: [
          Column(
            children: [
              const SizedBox(height: ApplicationStylesConstants.spacing20Sp),
              ProductCarousel(
                imagesUrls: state.imagesUrls,
                controller: controller,
                currentUrl: currentUrl,
              ),
              SizedBox(
                height: height * 0.55,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: state.products.length,
                    itemBuilder: (BuildContext ctx, index) {
                      final product = state.products.elementAt(index);
                      return SizedBox(
                        width: width * 0.7,
                        child: ProductCardHome(
                          productModel: product,
                          onTap: () => context.go('/productDetails', extra: product),
                          addToPurchaseList: () => cubit.addToCart(product: product, cartList: state.cartList),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ],
      );
    });
  }
}
