import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../theme.dart';

class AppButton extends StatelessWidget {
  final String title;
  final Function()? onTap;

  const AppButton({super.key, this.onTap, required this.title});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.maxFinite,
        height: buttonHeight,
        decoration: BoxDecoration(
          color: AppTheme.primaryColor(context),
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: [BoxShadow(color: AppTheme.buttonShadowColor(context), offset: Offset(0, 7), blurRadius: 15)],
        ),
        child: Center(
          child: Text(title, style: TextStyle(color: AppTheme.buttonTextColor(context))),
        ),
      ),
    );
  }
}
