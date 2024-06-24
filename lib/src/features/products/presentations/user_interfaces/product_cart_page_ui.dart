import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_products_demo/src/features/products/presentations/bussiness_components/products_cubit.dart';
import 'package:flutter_products_demo/src/features/products/presentations/bussiness_components/products_state.dart';

class ProductCardPage extends HookWidget {
  const ProductCardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProductsCubit>();
    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, state) {
        return Flex(
          direction: Axis.vertical,
          children: [
            const Text("InDevelopment"),
            FilledButton(
            onPressed: () => cubit.initialize, 
            child: Text("Home")),
            ],
        );
      }
    );
  }
}
