import 'package:gerenciamento_escolar/core/navigator/navigator_app.dart';
import 'package:gerenciamento_escolar/repository/repository_module.dart';
import 'package:gerenciamento_escolar/view/module_view.dart';
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
