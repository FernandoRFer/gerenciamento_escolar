import 'package:escola/core/router/navigator_app.dart';
import 'package:escola/core/router/routes.dart';

abstract class ISplashBloc {
  Future<void> load();
  void navigatorPop();
}

class SplashBloc implements ISplashBloc {
  final INavigatorApp _navigatorApp;

  SplashBloc(
    this._navigatorApp,
  );

  @override
  Future<void> load() async {
    await Future.delayed(const Duration(seconds: 3));
    _navigatorApp.pushReplacementNamed(AppRoutes.home);
  }

  @override
  void navigatorPop() {
    _navigatorApp.pop();
  }
}
