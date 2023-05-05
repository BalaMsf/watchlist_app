import 'package:flutter/material.dart';

const Color appPrimaryColor = Color(0xFF0041AE);
const Color appPrimaryLightColor = Color(0xFF282736);
const Color appAccentColor = Color(0xFF171927);
const Color appBackgroundColor = Color(0xFF1C1E30);
const Color appBarBackgroundColor = Color(0xFF1C1E30);
const Color appBorderColor = Color(0xFF303242);
const Color appTextColor = Color(0xFFCBCBCB);
const Color appAccentTextColor = Color(0xFF9798A1);
const Color appLightAccentTextColor = Color(0xFFFFFFFF);
const Color labelColor = Color(0xFFAEB2B7);
const Color appInputFillColor = Color(0xFF222337);
const Color snackbarBackgrouundColor = Color(0xFF222337);
const Color appOverlineColor = Color(0xFFCBCBCB);
const Color whiteColor = Color(0xFFFFFFFF);
const Color appFocusInputBorderColor = Color(0xFF212335);
const Color appIconColor = Color(0xFFFFFFFF);
const Color appAccentIconColor = Color(0xFF9798A1);
const Color appErrorColor = Color(0xFFF8646C);
const Color postiveColor = Color(0xFF34D178);
const Color transparent = Color(0x00000000);
const Color overLayColor = Color(0xFFFFFFFF);
const Color lightBlueColor = Color(0xFF6899F4);

ThemeData darkTheme() {
  return ThemeData(
    brightness: Brightness.dark,
    primaryColor: appPrimaryColor,
    primaryColorLight: appPrimaryLightColor,
    scaffoldBackgroundColor: appBackgroundColor,
    unselectedWidgetColor: labelColor,
    canvasColor: appInputFillColor,
    hoverColor: appAccentTextColor,
    secondaryHeaderColor: whiteColor,
    highlightColor: transparent,
    shadowColor: overLayColor,
    cardColor: lightBlueColor,
    hintColor: appTextColor,
  );
}
