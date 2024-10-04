import 'package:escola/theme/preferencies_user.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData flexThemeLight(IUserTheme controller) {
  return FlexThemeData.light(
      useMaterial3: true,
      colors: controller.value.scheme,
      scheme: _scheme,
      swapColors: _swapColors,
      usedColors: _usedColors,
      lightIsWhite: false,
      // appBarStyle: FlexAppBarStyle.primary,
      appBarElevation: _appBarElevation,
      appBarOpacity: _appBarOpacity,
      transparentStatusBar: _transparentStatusBar,
      tabBarStyle: _tabBarForAppBar,
      surfaceMode: _surfaceMode,
      blendLevel: _blendLevel,
      tooltipsMatchBackground: _tooltipsMatchBackground,
      textTheme: _textTheme,
      primaryTextTheme: _textTheme,
      keyColors: _keyColors,
      tones: _flexTonesLight,
      subThemesData: _useSubThemes ? _subThemesData : null,
      visualDensity: _visualDensity,
      platform: _platform,
      fontFamily: _fontFamily);
}

ThemeData flexThemeDark(IUserTheme controller) {
  return FlexThemeData.dark(
      useMaterial3: true,
      colors: controller.value.scheme,
      scheme: _scheme,
      swapColors: _swapColors,
      usedColors: _usedColors,
      darkIsTrueBlack: false,
      appBarStyle: null,
      appBarElevation: _appBarElevation,
      appBarOpacity: _appBarOpacity,
      transparentStatusBar: _transparentStatusBar,
      tabBarStyle: _tabBarForAppBar,
      surfaceMode: _surfaceMode,
      blendLevel: _blendLevel,
      tooltipsMatchBackground: _tooltipsMatchBackground,
      textTheme: _textTheme,
      primaryTextTheme: _textTheme,
      keyColors: _keyColors,
      tones: _flexTonesDark,
      subThemesData: _useSubThemes ? _subThemesData : null,
      visualDensity: _visualDensity,
      platform: _platform,
      fontFamily: _fontFamily);
}

const FlexScheme _scheme = FlexScheme.flutterDash;
const double _appBarElevation = 0.5;
const double _appBarOpacity = 0.94;
const bool _swapColors = false;
const int _usedColors = 6;

const FlexKeyColors _keyColors = FlexKeyColors(
  useKeyColors: false,
  useSecondary: true,
  useTertiary: true,
  keepPrimary: false,
  keepPrimaryContainer: false,
  keepSecondary: false,
  keepSecondaryContainer: false,
  keepTertiary: false,
  keepTertiaryContainer: false,
);

final FlexTones _flexTonesLight = FlexTones.material(Brightness.light);
final FlexTones _flexTonesDark = FlexTones.material(Brightness.dark);

const TextTheme _textTheme = TextTheme(
  displayMedium: TextStyle(fontSize: 41),
  displaySmall: TextStyle(fontSize: 36),
  labelSmall: TextStyle(fontSize: 11, letterSpacing: 0.5),
);

const FlexSurfaceMode _surfaceMode = FlexSurfaceMode.highScaffoldLowSurface;

const int _blendLevel = 0;

// const String _fontFamily = "Metrolopis";
String? _fontFamily = GoogleFonts.notoSans().fontFamily;

const bool _useSubThemes = true;
const FlexSubThemesData _subThemesData = FlexSubThemesData(
  interactionEffects: true,
  defaultRadius: 8,
  bottomSheetRadius: 24,
  useTextTheme: true,
  inputDecoratorBorderType: FlexInputBorderType.outline,
  inputDecoratorUnfocusedHasBorder: true,
  inputDecoratorSchemeColor: SchemeColor.primary,
  inputDecoratorBackgroundAlpha: 0,
  fabUseShape: false,
  fabSchemeColor: SchemeColor.secondaryContainer,
  chipSchemeColor: SchemeColor.primary,
  elevatedButtonElevation: 1,
  thickBorderWidth: 1.5,
  thinBorderWidth: 1,
  bottomNavigationBarSelectedLabelSchemeColor: SchemeColor.primary,
  bottomNavigationBarBackgroundSchemeColor: SchemeColor.background,
  navigationBarSelectedLabelSchemeColor: SchemeColor.tertiary,
  navigationBarUnselectedIconSchemeColor: SchemeColor.onSurface,
  navigationBarUnselectedLabelSchemeColor: SchemeColor.onSurface,
  navigationBarIndicatorSchemeColor: SchemeColor.tertiaryContainer,
  navigationBarIndicatorOpacity: 1,
  navigationBarBackgroundSchemeColor: SchemeColor.background,
  navigationBarMutedUnselectedIcon: true,
  navigationBarMutedUnselectedLabel: true,
  navigationBarSelectedLabelSize: 12,
  navigationBarUnselectedLabelSize: 10,
  navigationBarSelectedIconSize: 26,
  navigationBarUnselectedIconSize: 22,
);

const bool _transparentStatusBar = true;
const FlexTabBarStyle _tabBarForAppBar = FlexTabBarStyle.forAppBar;
const bool _tooltipsMatchBackground = true;
final VisualDensity _visualDensity = FlexColorScheme.comfortablePlatformDensity;
final TargetPlatform _platform = defaultTargetPlatform;
