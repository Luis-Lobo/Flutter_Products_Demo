import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_products_demo/src/core/components/products_bar.dart';
import 'package:flutter_products_demo/src/features/authentication/presentations/components/business_components/authentication_cubit.dart';
import 'package:flutter_products_demo/src/features/authentication/presentations/components/business_components/authentication_state.dart';
import 'package:flutter_products_demo/src/features/products/presentations/components/product_snack_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_products_demo/src/core/components/product_button.dart';
import 'package:flutter_products_demo/src/core/components/product_circular_progress_indicator.dart';
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
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  File? _image;
  bool _isLoading = false;
  String _errorMessage = "";

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    final cubit = context.read<AuthenticationCubit>();
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(listener: (context, currentState) {
      if (_formKey.currentState!.validate()) {
        _isLoading = true;
        if (currentState.registerSucess) {
          ScaffoldMessenger.of(context).showSnackBar(ProductSnackBar.showAdditionSnackBar(context: context, message: "User successfully registered"));
          context.go('/productsPage');
        } else {
          _errorMessage = "Error when trying to register user ${currentState.registerErrorMessage}";
        }
        _isLoading = false;
      }
    }, builder: (context, state) {
      return Scaffold(
        appBar: ProductsBar(
          title: l10n.welcome,
          onPop: () => context.pop(),
        ),
        body: Form(
          key: _formKey,
          child: Container(
            color: ApplicationColors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: ApplicationStylesConstants.spacing4Sp),
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
                const SizedBox(height: ApplicationStylesConstants.spacing8Sp),
                GestureDetector(
                  onTap: _pickImage,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: _image != null ? FileImage(_image!) : null,
                    child: _image == null ? const Icon(Icons.camera_alt, size: 30, color: Colors.white) : null,
                  ),
                ),
                const SizedBox(height: ApplicationStylesConstants.spacing8Sp),
                Flexible(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: ProductTextFormField(
                      hintText: l10n.name,
                      labelText: l10n.name,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return l10n.nameInsert;
                        }
                        return null;
                      },
                      onChanged: (value) {
                        _nameController.text = value;
                      },
                    ),
                  ),
                ),
                const SizedBox(height: ApplicationStylesConstants.spacing8Sp),
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
                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return l10n.emailAddressInvalid;
                        }
                        return null;
                      },
                      onChanged: (value) {
                        _emailController.text = value;
                      },
                    ),
                  ),
                ),
                const SizedBox(height: ApplicationStylesConstants.spacing8Sp),
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
                const SizedBox(height: ApplicationStylesConstants.spacing8Sp),
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
                        _confirmPasswordController.text = value;
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
                        ? const ProductCircularProgressIndicator()
                        : ProductButton(
                            textButton: l10n.createAccount,
                            borderRadius: BorderRadius.circular(16.0),
                            onPressed: () => cubit.registerUser(
                              name: _nameController.text,
                              email: _emailController.text,
                              password: _passwordController.text,
                              image: _image,
                            ),
                          ),
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
