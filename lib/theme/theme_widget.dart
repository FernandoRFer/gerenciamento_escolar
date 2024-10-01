import 'package:escola/theme/preferencies_user.dart';
import 'package:flutter/widgets.dart';

class ThemeWidget extends InheritedNotifier<IUserTheme>
    with WidgetsBindingObserver {
  const ThemeWidget(
      {super.key, required IUserTheme super.notifier, required super.child});

  static IUserTheme of(BuildContext context) {
    final inherited = context.dependOnInheritedWidgetOfExactType<ThemeWidget>();
    return inherited!.notifier!;
  }
}
