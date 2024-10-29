import 'package:flutter/material.dart';
import 'package:flutter_products_demo/src/core/theme/application_colors.dart';

class ProductTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final int? errorMaxLines;
  final String? hintText;
  final TextInputType? keyboardType;
  final String? labelText;
  final int? maxLength;
  final bool obscureText;
  final ValueChanged? onChanged;
  final ValueChanged? onSaved;
  final VoidCallback? onTap;
  final Icon? prefixIcon;
  final IconButton? sufixButtonIcon;
  final FormFieldValidator? validator;

  const ProductTextFormField(
      {
      this.controller,
      this.errorMaxLines,
      this.hintText,
      this.keyboardType,
      this.labelText,
      this.maxLength,
      this.obscureText = false,
      this.onChanged,
      this.onSaved,
      this.onTap,
      this.prefixIcon,
      this.sufixButtonIcon,
      this.validator,
      super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      keyboardType: keyboardType,
      controller: controller,
      maxLength: maxLength,
      cursorColor: ApplicationColors.red,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText ?? labelText,
        contentPadding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
          borderSide: const BorderSide(color: ApplicationColors.black36, width: 2.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: ApplicationColors.red, width: 4.0),
          borderRadius: BorderRadius.circular(32),
        ),
        prefixIcon: prefixIcon,
        suffixIcon: sufixButtonIcon,
        errorMaxLines: errorMaxLines,
      ),
      validator: validator,
      onChanged: onChanged,
      onSaved: onSaved,
      onTap: onTap,
    );
  }
}
