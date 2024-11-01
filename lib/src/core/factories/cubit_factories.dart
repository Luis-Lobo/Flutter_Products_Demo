import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter_products_demo/src/core/services/application_http_client.dart';
import 'package:flutter_products_demo/src/core/services/dio_http_client_impl.dart';
import 'package:flutter_products_demo/src/core/services/interceptors/application_interceptor_impl.dart';
import 'package:flutter_products_demo/src/core/storage/application_storage_impl.dart';
import 'package:flutter_products_demo/src/features/authentication/data/authentication_repository_impl.dart';
import 'package:flutter_products_demo/src/features/authentication/domain/use_cases/authentication_use_case_impl.dart';
import 'package:flutter_products_demo/src/features/authentication/presentations/components/business_components/authentication_cubit.dart';
import 'package:flutter_products_demo/src/features/products/data/products_repositoyy_impl.dart';
import 'package:flutter_products_demo/src/features/products/domain/use_cases/use_cases_products_impl.dart';
import 'package:flutter_products_demo/src/features/products/presentations/bussiness_components/products_cubit.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CubitFactories {

  static ProductsCubit get productsCubit => ProductsCubit(
        useCase: ProductsUseCaseImpl(
          repository: ProductsRepositoryImpl(
            httpClient: _getClient(),
          ),
        ),
      );

  static AuthenticationCubit get authenticationCubit => AuthenticationCubit(
        useCase:  AuthenticationUseCaseImpl(
          repository: AuthenticationRepositoryImpl(),
        ),
      );

  static ApplicationHttpClient _getClient({String? baseUrl}) {
    final dio = Dio(
      BaseOptions(
        baseUrl: "https://fakestoreapi.com",
        connectTimeout: const Duration(milliseconds: 30000),
        receiveTimeout: const Duration(milliseconds: 30000),
        sendTimeout: const Duration(milliseconds: 30000),
      ),
    );
    dio.httpClientAdapter = IOHttpClientAdapter(
      createHttpClient: () {
        final client = HttpClient();
        client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
        return client;
      },
    );

    return DioHttpClientImpl(
      interceptor: ApplicationInterceptorImpl(
        storage: const ApplicationStorageImpl(
          securedStorage: FlutterSecureStorage(),
        ),
      ),
      client: dio,
    );
  }
}
