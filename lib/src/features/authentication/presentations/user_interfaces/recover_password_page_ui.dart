import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_products_demo/src/core/components/product_button.dart';
import 'package:flutter_products_demo/src/core/components/product_circular_progress_indicator.dart';
import 'package:flutter_products_demo/src/core/components/product_text_form_field.dart';
import 'package:flutter_products_demo/src/core/components/products_bar.dart';
import 'package:flutter_products_demo/src/core/theme/application_colors.dart';
import 'package:flutter_products_demo/src/core/theme/application_styles_constants.dart';
import 'package:flutter_products_demo/src/features/authentication/presentations/components/business_components/authentication_cubit.dart';
import 'package:flutter_products_demo/src/features/authentication/presentations/components/business_components/authentication_state.dart';
import 'package:flutter_products_demo/src/features/authentication/presentations/components/error_message.dart';
import 'package:flutter_products_demo/src/features/products/presentations/components/product_snack_bar.dart';
import 'package:go_router/go_router.dart';

class RecoverPasswordPageUi extends StatefulWidget {
  const RecoverPasswordPageUi({super.key});

  @override
  State<RecoverPasswordPageUi> createState() => _RecoverPasswordPageUiState();
}

class _RecoverPasswordPageUiState extends State<RecoverPasswordPageUi> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _isLoading = false;
  String _errorMessage = "";

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    final cubit = context.read<AuthenticationCubit>();
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
        listener: (context, currentState) {
          if (_formKey.currentState!.validate()) {
        _isLoading = true;
        if (currentState.recoverPasswordSucess) {
          ProductSnackBar.showAdditionSnackBar(context: context, message: l10n.recoverPasswordSuccess);
        } else {
          _errorMessage = 'Recover password failed: ${currentState.loginErrorMessage}';
        }
        _isLoading = false;
      }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: ProductsBar(
              title: l10n.recoverPassword,
              onPop: () => context.pop(),
            ),
            body: Form(
              key: _formKey,
              child: Container(
                color: ApplicationColors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      l10n.recoverPasswordTitle,
                      style: textTheme.titleMedium?.copyWith(
                        color: ApplicationColors.black36,
                        fontWeight: FontWeight.w700,
                        fontSize: 32,
                      ),
                    ),
                    const SizedBox(height: ApplicationStylesConstants.spacing8Sp),
                    Text(
                      l10n.recoverPasswordSubTitle,
                      style: textTheme.titleMedium?.copyWith(
                        color: ApplicationColors.black36,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: ApplicationStylesConstants.spacing8Sp),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32.0),
                      child: ProductTextFormField(
                        hintText: l10n.emailAddress,
                        labelText: l10n.emailAddress,
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        prefixIcon: const Icon(Icons.email),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return l10n.emailAddressInsert;
                          }
                          return null;
                        },
                        onChanged: (value) {
                          _emailController.text = value;
                        },
                      ),
                    ),
                    const SizedBox(height: ApplicationStylesConstants.spacing8Sp),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32.0),
                      child: _isLoading ?
                        const ProductCircularProgressIndicator()
                      : ProductButton(
                        textButton: l10n.recoverPassword,
                        borderRadius: BorderRadius.circular(16.0),
                        onPressed: () => cubit.recoverPassword(email: _emailController.text),
                      ),
                    ),
                    const SizedBox(height: ApplicationStylesConstants.spacing4Sp),
                    if (_errorMessage.isNotEmpty) Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32.0),
                      child: ErrorMessage(message: _errorMessage),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
