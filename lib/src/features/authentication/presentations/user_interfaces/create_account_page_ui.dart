import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_products_demo/src/core/components/product_button.dart';
import 'package:flutter_products_demo/src/core/components/product_text_form_field.dart';
import 'package:flutter_products_demo/src/core/theme/application_colors.dart';
import 'package:flutter_products_demo/src/core/theme/application_styles_constants.dart';
import 'package:go_router/go_router.dart';

class CreateAccountPageUI extends StatefulWidget {
  const CreateAccountPageUI({super.key});

  @override
  State<CreateAccountPageUI> createState() => _CreateAccountPageUIState();
}

class _CreateAccountPageUIState extends State<CreateAccountPageUI> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Container(
        color: ApplicationColors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: ApplicationStylesConstants.spacing32Sp),
            Flexible(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Text(
                  l10n.createAccountOnFakeShopping,
                  textAlign: TextAlign.center,
                  style: textTheme.titleMedium?.copyWith(
                    color: ApplicationColors.red,
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            const SizedBox(height: ApplicationStylesConstants.spacing32Sp),
            Flexible(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: ProductTextFormField(
                  hintText: l10n.emailAddress,
                  labelText: l10n.emailAddress,
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
            ),
            const SizedBox(height: ApplicationStylesConstants.spacing32Sp),
            Flexible(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: ProductTextFormField(
                  hintText: l10n.password,
                  labelText: l10n.password,
                  obscureText: true,
                ),
              ),
            ),
            const SizedBox(height: ApplicationStylesConstants.spacing8Sp),
            Flexible(
              flex: 1,
              child: Text(
                l10n.forgotPassword,
                textAlign: TextAlign.center,
                style: textTheme.titleMedium?.copyWith(
                  color: ApplicationColors.darkBlue,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const SizedBox(height: ApplicationStylesConstants.spacing32Sp),
            Flexible(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: ProductButton(
                  textButton: l10n.createAccount,
                  borderRadius: BorderRadius.circular(16.0),
                  onPressed: () => context.go('/productsPages'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
