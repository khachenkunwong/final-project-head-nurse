// ignore_for_file: overridden_fields, annotate_overrides

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:shared_preferences/shared_preferences.dart';

const kThemeModeKey = '__theme_mode__';
SharedPreferences? _prefs;

enum DeviceSize {
  mobile,
  tablet,
  desktop,
}

abstract class FlutterFlowTheme {
  static DeviceSize deviceSize = DeviceSize.mobile;

  static Future initialize() async =>
      _prefs = await SharedPreferences.getInstance();
  static ThemeMode get themeMode {
    final darkMode = _prefs?.getBool(kThemeModeKey);
    return darkMode == null
        ? ThemeMode.system
        : darkMode
            ? ThemeMode.dark
            : ThemeMode.light;
  }

  static void saveThemeMode(ThemeMode mode) => mode == ThemeMode.system
      ? _prefs?.remove(kThemeModeKey)
      : _prefs?.setBool(kThemeModeKey, mode == ThemeMode.dark);

  static FlutterFlowTheme of(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? DarkModeTheme()
          : LightModeTheme();

  late Color primaryColor;
  late Color secondaryColor;
  late Color tertiaryColor;
  late Color alternate;
  late Color primaryBackground;
  late Color secondaryBackground;
  late Color primaryText;
  late Color secondaryText;

  late Color primaryRed;
  late Color primaryBlack;
  late Color primaryBlackGray;
  late Color primaryGray;
  late Color primaryGrayWhite;
  late Color stokeLightGray;
  late Color primaryBackground1;
  late Color secondaryWhite;
  late Color primaryBlue;
  late Color secondaryButtonDarkBlue;
  late Color primaryBlue01;
  late Color primaryBlue02;
  late Color secondaryBlueWhite;
  late Color primaryGreen;
  late Color primaryGreenLight;

  String get title1Family => typography.title1Family;
  TextStyle get title1 => typography.title1;
  String get title2Family => typography.title2Family;
  TextStyle get title2 => typography.title2;
  String get title3Family => typography.title3Family;
  TextStyle get title3 => typography.title3;
  String get subtitle1Family => typography.subtitle1Family;
  TextStyle get subtitle1 => typography.subtitle1;
  String get subtitle2Family => typography.subtitle2Family;
  TextStyle get subtitle2 => typography.subtitle2;
  String get bodyText1Family => typography.bodyText1Family;
  TextStyle get bodyText1 => typography.bodyText1;
  String get bodyText2Family => typography.bodyText2Family;
  TextStyle get bodyText2 => typography.bodyText2;

  Typography get typography => {
        DeviceSize.mobile: MobileTypography(this),
        DeviceSize.tablet: TabletTypography(this),
        DeviceSize.desktop: DesktopTypography(this),
      }[deviceSize]!;
}

DeviceSize getDeviceSize(BuildContext context) {
  final width = MediaQuery.of(context).size.width;
  if (width < 479) {
    return DeviceSize.mobile;
  } else if (width < 991) {
    return DeviceSize.tablet;
  } else {
    return DeviceSize.desktop;
  }
}

class LightModeTheme extends FlutterFlowTheme {
  late Color primaryColor = const Color(0xFF1033FD);
  late Color secondaryColor = const Color(0xFFD6D6D6);
  late Color tertiaryColor = const Color(0xFF000000);
  late Color alternate = const Color(0xFFFF5963);
  late Color primaryBackground = const Color(0xFFEDEDED);
  late Color secondaryBackground = const Color(0xFFF1F4F8);
  late Color primaryText = const Color(0xFF727272);
  late Color secondaryText = const Color(0xFFBDBDBD);

  late Color primaryRed = Color(0xFFFF0000);
  late Color primaryBlack = Color(0xFF000000);
  late Color primaryBlackGray = Color(0xFF393939);
  late Color primaryGray = Color(0xFF727272);
  late Color primaryGrayWhite = Color(0xFFBDBDBD);
  late Color stokeLightGray = Color(0xFFD6D6D6);
  late Color primaryBackground1 = Color(0xFFEDEDED);
  late Color secondaryWhite = Color(0xFFFFFBFB);
  late Color primaryBlue = Color(0xFF1033FD);
  late Color secondaryButtonDarkBlue = Color(0xFF008AB1);
  late Color primaryBlue01 = Color(0xFF00A2FD);
  late Color primaryBlue02 = Color(0xFF56CCF2);
  late Color secondaryBlueWhite = Color(0xFFB3DCE8);
  late Color primaryGreen = Color(0xFF00B12C);
  late Color primaryGreenLight = Color(0xFF00FD3F);
}

abstract class Typography {
  String get title1Family;
  TextStyle get title1;
  String get title2Family;
  TextStyle get title2;
  String get title3Family;
  TextStyle get title3;
  String get subtitle1Family;
  TextStyle get subtitle1;
  String get subtitle2Family;
  TextStyle get subtitle2;
  String get bodyText1Family;
  TextStyle get bodyText1;
  String get bodyText2Family;
  TextStyle get bodyText2;
}

class MobileTypography extends Typography {
  MobileTypography(this.theme);

  final FlutterFlowTheme theme;

  String get title1Family => 'Mitr';
  TextStyle get title1 => GoogleFonts.getFont(
        'Mitr',
        color: Colors.black,
        fontWeight: FontWeight.normal,
        fontSize: 40,
      );
  String get title2Family => 'Mitr';
  TextStyle get title2 => GoogleFonts.getFont(
        'Mitr',
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 28,
      );
  String get title3Family => 'Mitr';
  TextStyle get title3 => GoogleFonts.getFont(
        'Mitr',
        color: theme.secondaryText,
        fontWeight: FontWeight.normal,
        fontSize: 26,
      );
  String get subtitle1Family => 'Mitr';
  TextStyle get subtitle1 => GoogleFonts.getFont(
        'Mitr',
        color: theme.primaryBlack,
        fontWeight: FontWeight.normal,
        fontSize: 28,
      );
  String get subtitle2Family => 'Mitr';
  TextStyle get subtitle2 => GoogleFonts.getFont(
        'Mitr',
        color: theme.primaryBlack,
        fontWeight: FontWeight.normal,
        fontSize: 28,
        fontStyle: FontStyle.italic,
      );
  String get bodyText1Family => 'Mitr';
  TextStyle get bodyText1 => GoogleFonts.getFont(
        'Mitr',
        color: theme.secondaryWhite,
        fontWeight: FontWeight.normal,
        fontSize: 28,
      );
  String get bodyText2Family => 'Mitr';
  TextStyle get bodyText2 => GoogleFonts.getFont(
        'Mitr',
        color: Color(0xFF00A2FD),
        fontWeight: FontWeight.normal,
        fontSize: 28,
      );
}

class TabletTypography extends Typography {
  TabletTypography(this.theme);

  final FlutterFlowTheme theme;

  String get title1Family => 'Mitr';
  TextStyle get title1 => GoogleFonts.getFont(
        'Mitr',
        color: Colors.black,
        fontWeight: FontWeight.normal,
        fontSize: 40,
      );
  String get title2Family => 'Mitr';
  TextStyle get title2 => GoogleFonts.getFont(
        'Mitr',
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 28,
      );
  String get title3Family => 'Mitr';
  TextStyle get title3 => GoogleFonts.getFont(
        'Mitr',
        color: theme.secondaryText,
        fontWeight: FontWeight.normal,
        fontSize: 26,
      );
  String get subtitle1Family => 'Mitr';
  TextStyle get subtitle1 => GoogleFonts.getFont(
        'Mitr',
        color: theme.primaryBlack,
        fontWeight: FontWeight.normal,
        fontSize: 28,
      );
  String get subtitle2Family => 'Mitr';
  TextStyle get subtitle2 => GoogleFonts.getFont(
        'Mitr',
        color: theme.primaryBlack,
        fontWeight: FontWeight.normal,
        fontSize: 28,
        fontStyle: FontStyle.italic,
      );
  String get bodyText1Family => 'Mitr';
  TextStyle get bodyText1 => GoogleFonts.getFont(
        'Mitr',
        color: theme.secondaryWhite,
        fontWeight: FontWeight.normal,
        fontSize: 28,
      );
  String get bodyText2Family => 'Mitr';
  TextStyle get bodyText2 => GoogleFonts.getFont(
        'Mitr',
        color: Color(0xFF00A2FD),
        fontWeight: FontWeight.normal,
        fontSize: 28,
      );
}

class DesktopTypography extends Typography {
  DesktopTypography(this.theme);

  final FlutterFlowTheme theme;

  String get title1Family => 'Mitr';
  TextStyle get title1 => GoogleFonts.getFont(
        'Mitr',
        color: Colors.black,
        fontWeight: FontWeight.normal,
        fontSize: 40,
      );
  String get title2Family => 'Mitr';
  TextStyle get title2 => GoogleFonts.getFont(
        'Mitr',
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 28,
      );
  String get title3Family => 'Mitr';
  TextStyle get title3 => GoogleFonts.getFont(
        'Mitr',
        color: theme.secondaryText,
        fontWeight: FontWeight.normal,
        fontSize: 26,
      );
  String get subtitle1Family => 'Mitr';
  TextStyle get subtitle1 => GoogleFonts.getFont(
        'Mitr',
        color: theme.primaryBlack,
        fontWeight: FontWeight.normal,
        fontSize: 28,
      );
  String get subtitle2Family => 'Mitr';
  TextStyle get subtitle2 => GoogleFonts.getFont(
        'Mitr',
        color: theme.primaryBlack,
        fontWeight: FontWeight.normal,
        fontSize: 28,
        fontStyle: FontStyle.italic,
      );
  String get bodyText1Family => 'Mitr';
  TextStyle get bodyText1 => GoogleFonts.getFont(
        'Mitr',
        color: theme.secondaryWhite,
        fontWeight: FontWeight.normal,
        fontSize: 28,
      );
  String get bodyText2Family => 'Mitr';
  TextStyle get bodyText2 => GoogleFonts.getFont(
        'Mitr',
        color: Color(0xFF00A2FD),
        fontWeight: FontWeight.normal,
        fontSize: 28,
      );
}

class DarkModeTheme extends FlutterFlowTheme {
  late Color primaryColor = const Color(0xFF4B39EF);
  late Color secondaryColor = const Color(0xFF39D2C0);
  late Color tertiaryColor = const Color(0xFFEE8B60);
  late Color alternate = const Color(0xFFFF5963);
  late Color primaryBackground = const Color(0xFF1A1F24);
  late Color secondaryBackground = const Color(0xFF101213);
  late Color primaryText = const Color(0xFFFFFFFF);
  late Color secondaryText = const Color(0xFF95A1AC);

  late Color primaryRed = Color(0xFFFF0000);
  late Color primaryBlack = Color(0xFF000000);
  late Color primaryBlackGray = Color(0xFF393939);
  late Color primaryGray = Color(0xFF727272);
  late Color primaryGrayWhite = Color(0xFFBDBDBD);
  late Color stokeLightGray = Color(0xFFD6D6D6);
  late Color primaryBackground1 = Color(0xFFEDEDED);
  late Color secondaryWhite = Color(0xFFFFFBFB);
  late Color primaryBlue = Color(0xFF1033FD);
  late Color secondaryButtonDarkBlue = Color(0xFF008AB1);
  late Color primaryBlue01 = Color(0xFF00A2FD);
  late Color primaryBlue02 = Color(0xFF56CCF2);
  late Color secondaryBlueWhite = Color(0xFFB3DCE8);
  late Color primaryGreen = Color(0xFF00B12C);
  late Color primaryGreenLight = Color(0xFF00FD3F);
}

extension TextStyleHelper on TextStyle {
  TextStyle override({
    String? fontFamily,
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    double? letterSpacing,
    FontStyle? fontStyle,
    bool useGoogleFonts = true,
    TextDecoration? decoration,
    double? lineHeight,
  }) =>
      useGoogleFonts
          ? GoogleFonts.getFont(
              fontFamily!,
              color: color ?? this.color,
              fontSize: fontSize ?? this.fontSize,
              letterSpacing: letterSpacing ?? this.letterSpacing,
              fontWeight: fontWeight ?? this.fontWeight,
              fontStyle: fontStyle ?? this.fontStyle,
              decoration: decoration,
              height: lineHeight,
            )
          : copyWith(
              fontFamily: fontFamily,
              color: color,
              fontSize: fontSize,
              letterSpacing: letterSpacing,
              fontWeight: fontWeight,
              fontStyle: fontStyle,
              decoration: decoration,
              height: lineHeight,
            );
}
