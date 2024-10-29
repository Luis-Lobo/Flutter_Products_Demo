import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_products_demo/src/core/components/product_button.dart';
import 'package:flutter_products_demo/src/core/components/product_text_form_field.dart';
import 'package:flutter_products_demo/src/core/theme/application_colors.dart';
import 'package:flutter_products_demo/src/core/theme/application_styles_constants.dart';
import 'package:flutter_products_demo/src/features/authentication/presentations/components/error_message.dart';
import 'package:go_router/go_router.dart';

class CreateAccountPageUI extends StatefulWidget {
  const CreateAccountPageUI({super.key});

  @override
  State<CreateAccountPageUI> createState() => _CreateAccountPageUIState();
}

class _CreateAccountPageUIState extends State<CreateAccountPageUI> {
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmationController = TextEditingController();
  bool _isLoading = false;
  String _errorMessage = "";

  Future<void> createUser() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        await _auth.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
        setState(() {
          _errorMessage = '';
        });
        context.go('/productsPage');
      } catch (e) {
        setState(() {
          _errorMessage = 'Failed to register: ${e.toString()}';
        });
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Container(
          color: ApplicationColors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: ApplicationStylesConstants.spacing32Sp),
              Flexible(
                flex: 2,
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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return l10n.passwordInsert;
                      }
                      if (value.length < 6) {
                        return l10n.passwordLength;
                      }
                      return null;
                    },
                    onChanged: (value) {
                      _passwordController.text = value;
                    },
                  ),
                ),
              ),
              const SizedBox(height: ApplicationStylesConstants.spacing32Sp),
              Flexible(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: ProductTextFormField(
                    hintText: l10n.passwordConfirmation,
                    labelText: l10n.passwordConfirmation,
                    obscureText: true,
                    validator: (value) {
                      if (value != _passwordController.text) {
                        return l10n.passwordValidation;
                      }
                      return null;
                    },
                    onChanged: (value) {
                      _passwordConfirmationController.text = value;
                    },
                  ),
                ),
              ),
              const SizedBox(height: ApplicationStylesConstants.spacing32Sp),
              Flexible(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: _isLoading
                      ? const CircularProgressIndicator()
                      : ProductButton(
                          textButton: l10n.createAccount,
                          borderRadius: BorderRadius.circular(16.0),
                          onPressed: createUser,
                        ),
                ),
              ),
              const SizedBox(height: ApplicationStylesConstants.spacing4Sp),
              if (_errorMessage.isNotEmpty) ErrorMessage(message: _errorMessage)
            ],
          ),
        ),
      ),
    );
  }
}
