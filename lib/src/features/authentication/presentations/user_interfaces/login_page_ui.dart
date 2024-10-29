import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_products_demo/src/core/components/product_button.dart';
import 'package:flutter_products_demo/src/core/components/product_text_form_field.dart';
import 'package:flutter_products_demo/src/core/theme/application_colors.dart';
import 'package:flutter_products_demo/src/core/theme/application_styles_constants.dart';
import 'package:flutter_products_demo/src/features/authentication/presentations/components/error_message.dart';
import 'package:go_router/go_router.dart';

class LoginPageUi extends StatefulWidget {
  const LoginPageUi({super.key});

  @override
  State<LoginPageUi> createState() => _LoginPageUiState();
}

class _LoginPageUiState extends State<LoginPageUi> {
  bool _obscureText = true;
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  String _errorMessage = "";

  Future<void> login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      try {
        await _auth.signInWithEmailAndPassword(email: _emailController.text, password: _passwordController.text);
        setState(() {
          _errorMessage = '';
        });
         context.go('/productsPage');
      } catch (e) {
        setState(() {
          _errorMessage = 'Login failed: ${e.toString()}';
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
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
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
                ),
                const SizedBox(height: ApplicationStylesConstants.spacing16Sp),
                Flexible(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: ProductTextFormField(
                      hintText: l10n.password,
                      labelText: l10n.password,
                      controller: _passwordController,
                      obscureText: _obscureText,
                      prefixIcon: const Icon(Icons.lock),
                      sufixButtonIcon: IconButton(
                        icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
                        onPressed: () => setState(() {
                          _obscureText = !_obscureText;
                        }),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return l10n.passwordInsert;
                        }
                        return null;
                      },
                      onChanged: (value) {
                        _passwordController.text = value;
                      },
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
                    child: _isLoading? 
                    const CircularProgressIndicator()
                    :ProductButton(
                      textButton: l10n.signIn,
                      borderRadius: BorderRadius.circular(16.0),
                      onPressed: login,
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
                const SizedBox(height: ApplicationStylesConstants.spacing4Sp),
              if (_errorMessage.isNotEmpty) 
                  ErrorMessage(message: _errorMessage)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
