import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
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
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  File? _image;
  bool _isLoading = false;
  String _errorMessage = "";

  Future<void> registerUser() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    setState(() {
      _isLoading = true;
    });

    if (_formKey.currentState!.validate()) {
      try {
        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        String uid = userCredential.user!.uid;

        if (_image != null) {
          String imageName = DateTime.now().millisecondsSinceEpoch.toString();
          Reference file = _storage.ref().child(uid).child(imageName);

          UploadTask uploadTask = file.putFile(_image!);
          TaskSnapshot taskSnapshot = await uploadTask;

          String photoUrl = await taskSnapshot.ref.getDownloadURL();

          await _firestore.collection('users').doc(uid).set({'name': name, 'email': email, 'photoUrl': photoUrl});
        } else {
          await _firestore.collection('users').doc(uid).set({
            'name': name,
            'email': email,
          });
        }

        ScaffoldMessenger.of(context).showSnackBar(ProductSnackBar.showAdditionSnackBar(context: context, message: "User successfully registered"));
        context.go('/productsPage');
      } catch (error) {
        // ignore: avoid_print
        print(error);
        _errorMessage = "Error when trying to register user $error";
      }
    }
    setState(() {
      _isLoading = false;
    });
  }

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
    return Scaffold(
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
                          onPressed: registerUser,
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
