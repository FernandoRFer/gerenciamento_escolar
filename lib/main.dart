import 'package:escola/core/module_init.dart';
import 'package:escola/core/router/routes.dart';
import 'package:escola/theme/app_color.dart';
import 'package:escola/theme/flex_theme.dart';
import 'package:escola/theme/preferencies_user.dart';
import 'package:escola/theme/theme_widget.dart';
import 'package:flutter/material.dart';

void main() async {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  WidgetsFlutterBinding.ensureInitialized();

  AppModule(navigatorKey).configure();

  IUserTheme userTheme = UserTheme(UserThemeModel(
    scheme: AppColor.defultColor,
  ));
  userTheme.setTheme();

  return runApp(
      ThemeWidget(notifier: userTheme, child: AppWidget(navigatorKey)));
}

class AppWidget extends StatefulWidget {
  final GlobalKey<NavigatorState> _navigatorKey;
  const AppWidget(
    this._navigatorKey, {
    super.key,
  });

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> with WidgetsBindingObserver {
  @override
  Future<void> didChangePlatformBrightness() async {
    if (context.mounted) {
      final userTheme = ThemeWidget.of(context);
      userTheme.setTheme();
    }
    super.didChangePlatformBrightness();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userTheme = ThemeWidget.of(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      navigatorKey: widget._navigatorKey,
      title: 'Escola',
      theme: flexThemeLight(userTheme),
      darkTheme: flexThemeDark(userTheme),
      themeMode: userTheme.value.themeMode,
      initialRoute: AppRoutes.initial,
      routes: AppRoutes.routes,
      // home: const MatriculaView(),
    );
  }
}
