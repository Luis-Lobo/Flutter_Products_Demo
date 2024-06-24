import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_products_demo/src/features/products/domain/models/product_model.dart';
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
  late AppLocalizations _l10n;

  @override
  Widget build(BuildContext context) {
    _l10n = AppLocalizations.of(context)!;
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
        ],
      ),
    );
  }
}
