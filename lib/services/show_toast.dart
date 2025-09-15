import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

import '../theme.dart';

showToast(String title, String description, bool error) {
  toastification.show(
    type: ToastificationType.success,
    style: ToastificationStyle.flat,
    autoCloseDuration: const Duration(seconds: 5),
    title: Text(title),
    description: RichText(text: TextSpan(text: description)),
    alignment: Alignment.topRight,
    direction: TextDirection.ltr,
    animationDuration: const Duration(milliseconds: 300),
    animationBuilder: (context, animation, alignment, child) {
      return FadeTransition(opacity: animation, child: child);
    },
    primaryColor: AppTheme.toastPrimaryColor(),
    showIcon: false,
    backgroundColor: error ? AppTheme.toastBackgroundErrorColor() : AppTheme.toastBackgroundColor(),
    foregroundColor: AppTheme.toastForegroundColor(),
    padding: const EdgeInsets.symmetric(horizontal: appPadding, vertical: appPadding),
    margin: const EdgeInsets.symmetric(horizontal: appPadding, vertical: appPadding),
    borderRadius: BorderRadius.circular(borderRadius),

    showProgressBar: true,

    closeOnClick: true,
    pauseOnHover: true,
    dragToClose: true,
    applyBlurEffect: true,
  );
}
