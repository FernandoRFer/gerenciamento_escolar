import 'package:escola/core/navigator/navigator_app.dart';
import 'package:escola/repository/repository_module.dart';
import 'package:escola/view/module_view.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class AppModule {
  final GlobalKey<NavigatorState> navigatorKey;
  AppModule(
    this.navigatorKey,
  );
  static GetIt getIt = GetIt.instance;

  void configure() {
    ViewModule.configure();
    RepositoryModule.configure();

    getIt
        .registerLazySingleton<INavigatorApp>(() => NavigatorApp(navigatorKey));
  }
}
