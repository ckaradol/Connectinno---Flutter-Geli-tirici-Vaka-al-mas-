import 'package:flutter/material.dart';

import '../theme.dart';

class AppTextFormField extends StatelessWidget {
 final TextEditingController? controller;
  final TextInputType? textType;
  final bool? obsecureText;
  final String? hintText;
  final Widget? suffixIcon;
  final Function()? onTap;

  const AppTextFormField({
    super.key, this.hintText, this.suffixIcon, this.obsecureText, this.textType, this.controller, this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onTap: onTap,
      keyboardType: textType,
      obscureText: obsecureText ?? false,
      decoration: InputDecoration(
          fillColor: AppTheme.fillColor(context),
          filled: true,
          hintText: hintText,
          suffixIcon: suffixIcon,
          hintStyle: TextStyle(color: AppTheme.hintColor(context), fontSize: 15),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none)
      ),
    );
  }
}