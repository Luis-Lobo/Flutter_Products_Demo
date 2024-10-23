import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_products_demo/src/core/components/product_button.dart';
import 'package:flutter_products_demo/src/core/components/product_text_form_field.dart';
import 'package:flutter_products_demo/src/core/theme/application_colors.dart';
import 'package:flutter_products_demo/src/core/theme/application_styles_constants.dart';
import 'package:go_router/go_router.dart';

class LoginPageUi extends StatefulWidget {
  const LoginPageUi({super.key});

  @override
  State<LoginPageUi> createState() => _LoginPageUiState();
}

class _LoginPageUiState extends State<LoginPageUi> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Container(
          color: ApplicationColors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                flex: 13,
                child: Image.asset(
                  "lib/src/core/assets/marketing.jpg",
                  height: height * 0.5,
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(height: ApplicationStylesConstants.spacing8Sp),
              Flexible(
                flex: 1,
                child: Center(
                  child: Text(
                    l10n.fakeShoppingApp,
                    style: textTheme.titleMedium?.copyWith(
                      color: ApplicationColors.red,
                      fontWeight: FontWeight.w700,
                      fontSize: 32,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: ApplicationStylesConstants.spacing16Sp),
              Flexible(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: ProductTextFormField(
                    hintText: l10n.emailAddress,
                    labelText: l10n.emailAddress,
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: const Icon(Icons.email),
                  ),
                ),
              ),
              const SizedBox(height: ApplicationStylesConstants.spacing16Sp),
              Flexible(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: ProductTextFormField(
                    hintText: l10n.password,
                    labelText: l10n.password,
                    obscureText: _obscureText,
                    prefixIcon: const Icon(Icons.lock),
                    sufixButtonIcon: IconButton(
                      icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
                      onPressed: () => setState(() {
                        _obscureText = !_obscureText;
                      }),
                    ), 
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
              const SizedBox(height: ApplicationStylesConstants.spacing16Sp),
              Flexible(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: ProductButton(
                    textButton: l10n.signIn,
                    borderRadius: BorderRadius.circular(16.0),
                    onPressed: () => context.go('/productsPages'),
                  ),
                ),
              ),
              const SizedBox(height: ApplicationStylesConstants.spacing16Sp),
              Flexible(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: ProductButton(
                    textButton: l10n.createAccount,
                    borderRadius: BorderRadius.circular(16.0),
                    onPressed: () => context.go('/createAccountPage'),
                  ),
                ),
              ), 
            ],
          ),
        ),
      ),
    );
  }
}
