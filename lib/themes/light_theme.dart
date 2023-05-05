import 'package:flutter/material.dart';

const Color appPrimaryColor = Color(0xFF3977DE);
const Color appPrimaryLightColor = Color(0xFFD7E4F9);
const Color appAccentColor = Color(0xFFF8F8F8);
const Color appBackgroundColor = Color(0xFFFFFFFF);
const Color appBarBackgroundColor = Color(0xFFFFFFFF);
const Color appBorderColor = Color(0xFFEAEBEC);
const Color appTextColor = Color(0xFF353F4A);
const Color appAccentTextColor = Color(0xFF717880);
const Color appLightAccentTextColor = Color(0xFF636573);
const Color labelColor = Color(0xFFAEB2B7);
const Color appInputFillColor = Color(0xFFF1F1F1);
const Color snackbarBackgroundColor = Color(0xFFDEDEDE);
const Color appOverlineColor = appAccentTextColor;
const Color blackColor = Color(0xFF1C1E30);
const Color appInputBorderColor = Color(0xFFEAEBEC);
const Color appIconColor = Color(0xFF353F4A);
const Color appAccentIconColor = Color(0xFF717880);
const Color appErrorColor = Color(0xFFD83831);
const Color postiveColor = Color(0xFF34D178);
const Color transparent = Color(0x00000000);
const Color whiteColor = Color(0xFFFFFFFF);
const Color overLayColor = Color(0xFF1C1E30);
const Color lightBlueColor = Color(0xFF6899F4);

ThemeData lightTheme() {
  return ThemeData(
      brightness: Brightness.light,
      primaryColor: appPrimaryColor,
      primaryColorLight: appPrimaryLightColor,
      scaffoldBackgroundColor: appBackgroundColor,
      unselectedWidgetColor: labelColor,
      canvasColor: appInputFillColor,
      secondaryHeaderColor: blackColor,
      splashColor: whiteColor,
      hoverColor: appAccentTextColor,
      highlightColor: transparent,
      cardColor: appPrimaryLightColor,
      hintColor: appLightAccentTextColor);
}
