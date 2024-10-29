import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_products_demo/src/core/components/product_button.dart';
import 'package:flutter_products_demo/src/core/components/product_text_form_field.dart';
import 'package:flutter_products_demo/src/core/theme/application_colors.dart';
import 'package:flutter_products_demo/src/core/theme/application_styles_constants.dart';
import 'package:flutter_products_demo/src/features/products/domain/models/product_payment_model.dart';
import 'package:flutter_products_demo/src/features/products/presentations/bussiness_components/products_cubit.dart';
import 'package:flutter_products_demo/src/features/products/presentations/bussiness_components/products_state.dart';
import 'package:flutter_products_demo/src/features/products/presentations/components/product_snack_bar.dart';

class ProductPaymentUI extends HookWidget {
  const ProductPaymentUI({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProductsCubit>();
    final l10n = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final cardNumberController = TextEditingController();
    final cardHolderNameController = TextEditingController();
    final expirationDateController = TextEditingController();
    final securityCodeController = TextEditingController();

    void submit() {
      if (formKey.currentState!.validate()) {
        formKey.currentState!.save();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.paymentProcess)),
        );
        // TODO - This model will be sent to a fake payment API
        // using method POST
        final productPaymentModel = ProductPaymentModel(
          cardHolderName: cardNumberController.text,
          cardNumber: cardHolderNameController.text,
          expirationDate: expirationDateController.text,
          securityCode: securityCodeController.text,
        );
      }
    }

    return BlocConsumer<ProductsCubit, ProductsState>(listener: (context, currentState) {
      if (currentState.removeProductInCartList == true) {
        ProductSnackBar.showRemoveSnackBar(context: context, message: l10n.removeToCard);
        cubit.resetStatesSnackBar();
      }
    }, builder: (context, state) {
      return Flex(
        direction: Axis.vertical,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: Form(
              key: formKey,
              child: Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ProductTextFormField(
                      hintText: l10n.cardNumber,
                      labelText: l10n.cardNumber,
                      controller: cardNumberController,
                      maxLength: 16,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return l10n.cardNumberInsert;
                        }
                        if (value.length != 16) {
                          return l10n.cardNumberAlertLenght;
                        }
                        return null;
                      },
                      onSaved: (value) => cardNumberController.text = value,
                    ),
                    const SizedBox(height: ApplicationStylesConstants.spacing16Sp),
                    ProductTextFormField(
                      hintText: l10n.cardHolderName,
                      labelText: l10n.cardHolderName,
                      controller: cardHolderNameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return l10n.cardHolderNameInsert;
                        }
                        return null;
                      },
                      onSaved: (value) => cardHolderNameController.text = value,
                    ),
                    const SizedBox(height: ApplicationStylesConstants.spacing16Sp),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: ProductTextFormField(
                            hintText: l10n.expirationDate,
                            labelText: l10n.expirationDate,
                            controller: expirationDateController,
                            maxLength: 5,
                            errorMaxLines: 5,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return l10n.expirationDateInsert;
                              }
                              RegExp regExp = RegExp(r'^(0[1-9]|1[0-2])\/?([0-9]{2})$');
                              if (!regExp.hasMatch(value)) {
                                return l10n.expirationDateFormat;
                              }
                              return null;
                            },
                            onSaved: (value) => expirationDateController.text = value,
                          ),
                        ),
                        const SizedBox(width: ApplicationStylesConstants.spacing8Sp),
                        Expanded(
                          child: ProductTextFormField(
                            hintText: l10n.securityCode,
                            labelText: l10n.securityCode,
                            controller: securityCodeController,
                            maxLength: 3,
                            errorMaxLines: 5,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return l10n.securityCodeInsert;
                              }
                              if (value.length != 3) {
                                return l10n.securityCodeAlertLenght;
                              }
                              return null;
                            },
                            onSaved: (value) => securityCodeController.text = value,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Card(
            child: Column(
              children: [
                const SizedBox(height: ApplicationStylesConstants.spacing20Sp),
                Text(
                  l10n.totalPurchasePrice,
                  style: textTheme.titleLarge?.copyWith(
                    color: ApplicationColors.black36,
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                  ),
                ),
                Text(
                  state.totalPurchasePrice.toStringAsFixed(2),
                  style: textTheme.titleLarge?.copyWith(
                    color: ApplicationColors.black36,
                    fontWeight: FontWeight.w700,
                    fontSize: 32,
                  ),
                ),
              ],
            ),
          ),
          ProductButton(
            textButton: l10n.buy,
            borderRadius: BorderRadius.circular(16.0),
            onPressed: submit,
          ),
        ],
      );
    });
  }
}
