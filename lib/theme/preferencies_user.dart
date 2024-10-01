import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

mixin IUserTheme implements ValueNotifier<UserThemeModel> {
  void setTheme();
}

class UserTheme extends ValueNotifier<UserThemeModel> implements IUserTheme {
  UserTheme(super.value);

  @override
  void setTheme() {
    ThemeMode themeMode = ThemeMode.light;

    final brightness =
        WidgetsBinding.instance.platformDispatcher.platformBrightness;
    if (brightness == Brightness.dark) {
      themeMode = ThemeMode.dark;
    }

    value = value.copyWith(themeMode: themeMode);
  }
}

class UserThemeModel {
  ThemeMode themeMode;
  FlexSchemeColor scheme;
  UserThemeModel({
    required this.scheme,
    this.themeMode = ThemeMode.light,
  });

  UserThemeModel copyWith({
    FlexSchemeColor? scheme,
    ThemeMode? themeMode,
  }) {
    return UserThemeModel(
      scheme: scheme ?? this.scheme,
      themeMode: themeMode ?? this.themeMode,
    );
  }
}
