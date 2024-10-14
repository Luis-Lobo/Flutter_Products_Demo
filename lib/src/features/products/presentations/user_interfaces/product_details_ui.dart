import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_products_demo/src/features/products/domain/models/product_model.dart';
import 'package:flutter_products_demo/src/features/products/presentations/bussiness_components/products_cubit.dart';
import 'package:flutter_products_demo/src/features/products/presentations/bussiness_components/products_state.dart';
import 'package:flutter_products_demo/src/features/products/presentations/components/product_card_details.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_products_demo/src/features/products/presentations/components/products_bar.dart';

class ProductDetailsUI extends StatefulWidget {
  final ProductModel productModel;

  const ProductDetailsUI({
    required this.productModel,
    super.key});

  @override
  State<ProductDetailsUI> createState() => _ProductDetailsUIState();
}

class _ProductDetailsUIState extends State<ProductDetailsUI> {

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
     final cubit = context.read<ProductsCubit>();
    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, state) {
        return Scaffold(
          appBar:  ProductsBar(
            icon: Icons.draw,
            title: widget.productModel.title,
          ),
          body: Column(
            children: [
              ProductCardDetails(
                productModel: widget.productModel,
                onTap: () {},
              ),
              SizedBox(
                child: ElevatedButton(
                    onPressed: () => context.go('/'), child: const Text("voltar")),
              ),
              ElevatedButton(
                    child: Text(l10n.add),
                    onPressed: () => cubit.addToCart(product: widget.productModel, cartList: state.cartList),
                    ),
            ],
          ),
        );
      }
    );
  }
}
