import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_products_demo/src/features/products/presentations/bussiness_components/products_cubit.dart';
import 'package:flutter_products_demo/src/features/products/presentations/bussiness_components/products_state.dart';
import 'package:flutter_products_demo/src/features/products/presentations/components/product_card_home.dart';
import 'package:go_router/go_router.dart';

class ProductsHomeUI extends HookWidget {
  const ProductsHomeUI({super.key});
  
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, state) {
        return Flex(
          direction: Axis.vertical,
          children: [
            Column(
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
            
            ],
        );
      }
    );
  }
}