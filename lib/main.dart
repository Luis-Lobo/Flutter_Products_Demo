import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_products_demo/core/services/factories/cubit_factories.dart';
import 'package:flutter_products_demo/features/products/presentations/bussiness_components/products_cubit.dart';
import 'package:flutter_products_demo/features/products/presentations/components/product_card_component.dart';
import 'package:flutter_products_demo/features/products/presentations/components/products_bar.dart';

import 'features/products/presentations/bussiness_components/products_state.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ProductsHome(),
    );
  }
}

class ProductsHome extends StatefulWidget {
  const ProductsHome({super.key});

  @override
  State<ProductsHome> createState() => _ProductsHomeState();
}

class _ProductsHomeState extends State<ProductsHome> {
  final ProductsCubit _cubit = CubitFactories.productsCubit;

  
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _cubit.getProducts();
    });
  }


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsState>(
      bloc: _cubit,
      builder: (context, state) {
        if (state is ProductsErrorState) {
          return  Scaffold(
              appBar: const ProductsBar(
                title: "Error",
                icon: Icons.credit_card,
              ),
              body: Center(
                child: Text(state.message),
              ),
            );
        } if (state is ProductsSuccessState) {
          return Scaffold(
          appBar:  const ProductsBar(
            icon: Icons.draw,
            title: "Products List",
            subtitle: "products",
            
          ) ,
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ListView.builder(
                        shrinkWrap: true,
                        primary: false,
                        itemCount: state.products.length,
                        itemBuilder: (context, index) {
                          final product = state
                              .products
                              .elementAt(index);
                          return Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: ProductCardComponent(
                              productModel: product,
                              onTap: () => {}
                            ),
                          );
                        },
                      ),
                ],
              ),
            ),
          ),
            
          );
        } else {
          return const Scaffold(
              appBar: ProductsBar(
                title: "loading",
                icon: Icons.credit_card,
              ),
              body: CircularProgressIndicator(),
            );
        }
      }
    );
  }
}
