import 'package:gerenciamento_escolar/core/module_init.dart';
import 'package:gerenciamento_escolar/core/router/routes.dart';
import 'package:gerenciamento_escolar/core/utils/request_settings.dart';
import 'package:gerenciamento_escolar/theme/app_color.dart';
import 'package:gerenciamento_escolar/theme/flex_theme.dart';
import 'package:gerenciamento_escolar/theme/preferencies_user.dart';
import 'package:gerenciamento_escolar/theme/theme_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  WidgetsFlutterBinding.ensureInitialized();
  RequestSettings.getEnvironmentvariable();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

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
