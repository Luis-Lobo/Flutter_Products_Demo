import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_products_demo/src/core/factories/cubit_factories.dart';
import 'package:flutter_products_demo/src/features/authentication/presentations/components/business_components/authentication_cubit.dart';
import 'package:flutter_products_demo/src/features/authentication/presentations/user_interfaces/create_account_page_ui.dart';
import 'package:flutter_products_demo/src/features/authentication/presentations/user_interfaces/login_page_ui.dart';
import 'package:flutter_products_demo/src/features/authentication/presentations/user_interfaces/recover_password_page_ui.dart';
import 'package:flutter_products_demo/src/features/products/domain/models/product_model.dart';
import 'package:flutter_products_demo/src/features/products/presentations/user_interfaces/product_details_ui.dart';
import 'package:flutter_products_demo/src/features/products/presentations/bussiness_components/products_cubit.dart';
import 'package:flutter_products_demo/src/features/products/presentations/user_interfaces/products_pages_ui.dart';
import 'package:go_router/go_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyCs46ML_i-f2HXHHL0e_IJ85ChlI-IQ73g",
            authDomain: "fake-shopping-app-99d76.firebaseapp.com",
            projectId: "fake-shopping-app-99d76",
            storageBucket: "fake-shopping-app-99d76.appspot.com",
            messagingSenderId: "1092077678198",
            appId: "1:1092077678198:web:64633c4056e0c8e9757957",
            measurementId: "G-04XWQRKRQQ"));
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const LoginPageUi();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'productDetails',
          builder: (BuildContext context, GoRouterState state) {
            final productModel = state.extra! as ProductModel;
            return ProductDetailsUI(
              productModel: productModel,
            );
          },
        ),
        GoRoute(
          path: 'productsPage',
          builder: (BuildContext context, GoRouterState state) {
            return ProductsPagesUI();
          },
        ),
        GoRoute(
          path: 'createAccountPage',
          builder: (BuildContext context, GoRouterState state) {
            return const CreateAccountPageUI();
          },
        ),
        GoRoute(
          path: 'recoverPasswordPage',
          builder: (BuildContext context, GoRouterState state) {
            return const RecoverPasswordPageUi();
          },
        ),
      ],
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProductsCubit>(
          create: (context) => CubitFactories.productsCubit,
        ),
        BlocProvider<AuthenticationCubit>(
          create: (context) => CubitFactories.authenticationCubit,
        ),
      ],
      child: MaterialApp.router(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routerConfig: _router,
      ),
    );
  }
}
