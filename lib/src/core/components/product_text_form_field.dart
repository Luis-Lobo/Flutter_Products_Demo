import 'package:flutter/material.dart';
import 'package:flutter_products_demo/src/core/theme/application_colors.dart';

class ProductTextFormField extends StatelessWidget {
  final String? hintText;
  final TextInputType? keyboardType;
  final String? labelText;
  final bool obscureText;
  final Icon? prefixIcon;
  final IconButton? sufixButtonIcon;
  final ValueChanged? onChanged;
  final VoidCallback? onTap;

  const ProductTextFormField({
    this.hintText, 
    this.keyboardType, 
    this.labelText, 
    this.obscureText = false, 
    this.prefixIcon,
    this.sufixButtonIcon,
    this.onChanged,
    this.onTap,
    super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      keyboardType: keyboardType,
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
      ),
      onChanged: onChanged,
      onTap: onTap,
    );
  }
}
