import "package:flutter/material.dart";

class LightTheme {
  static const Color backgroundColor = Color(0xffF0F3F8);
  static const Color inactiveColor = Color(0xffEDF1F7);
  static const Color onboardBackgroundColor = Colors.white;
  static const Color primaryColor = Color(0xff007AFF);
  static const Color hintColor = Color(0xff8F9BB3);
  static const Color bottomBarText = Color(0xffC5CEE0);
  static const Color helpYouTextColor = Color(0xff9CC1E9);
  static const Color titleTextColor = Color(0xff222B45);
  static const Color buttonShadowColor = Color.fromRGBO(0, 149, 255, 0.28);
  static const Color fillColor = Colors.white;
  static const Color subtitleColor = Color(0xff687C97);
  static const Color buttonTextColor = Colors.white;
}

const double defaultPadding = 40;
const double appPadding = 16;
const double iconPadding = 16;
const double iconSize = 24;
const double borderRadius = 12;
const double borderRadiusHome = 20;
const double buttonHeight = 56;

class DarkTheme {
  static const Color onboardBackgroundColor = Colors.white;
  static const Color inactiveColor = Color(0xffEDF1F7);
  static const Color backgroundColor = Color(0xffF0F3F8);
  static const Color primaryColor = Color(0xff007AFF);
  static const Color bottomBarText = Color(0xffC5CEE0);
  static const Color helpYouTextColor = Color(0xff9CC1E9);
  static const Color titleTextColor = Color(0xff222B45);
  static const Color hintColor = Color(0xff8F9BB3);
  static const Color subtitleColor = Color(0xff687C97);
  static const Color fillColor = Colors.white;
  static const Color buttonShadowColor = Color.fromRGBO(0, 149, 255, 0.28);
  static const Color buttonTextColor = Colors.white;
}

class AppTheme {
  static Color backgroundColor(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.dark ? DarkTheme.backgroundColor : LightTheme.backgroundColor;
  }

  static Color onboardBackgroundColor(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.dark ? DarkTheme.onboardBackgroundColor : LightTheme.onboardBackgroundColor;
  }

  static Color inactiveColor(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.dark ? DarkTheme.inactiveColor : LightTheme.inactiveColor;
  }

  static Color subtitleColor(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.dark ? DarkTheme.subtitleColor : LightTheme.subtitleColor;
  }

  static Color primaryColor(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.dark ? DarkTheme.primaryColor : LightTheme.primaryColor;
  }

  static Color helpYouTextColor(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.dark ? DarkTheme.helpYouTextColor : LightTheme.helpYouTextColor;
  }

  static Color bottomBarText(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.dark ? DarkTheme.bottomBarText : LightTheme.bottomBarText;
  }

  static Color hintColor(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.dark ? DarkTheme.hintColor : LightTheme.hintColor;
  }

  static Color fillColor(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.dark ? DarkTheme.fillColor : LightTheme.fillColor;
  }

  static Color titleTextColor(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.dark ? DarkTheme.titleTextColor : LightTheme.titleTextColor;
  }

  static Color buttonTextColor(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.dark ? DarkTheme.buttonTextColor : LightTheme.buttonTextColor;
  }

  static Color buttonShadowColor(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.dark ? DarkTheme.buttonShadowColor : LightTheme.buttonShadowColor;
  }
}

class AppAssets {
  static const String logo = "assets/icons/logo.svg";
  static const String dateOfBirth = "assets/icons/date_of_birth_icon.svg";
  static const String visibleOff = "assets/icons/visible_off.svg";
  static const String visible = "assets/icons/visible.svg";
  static const String googleLogo = "assets/icons/google_icon.svg";
}
