import 'package:get_it/get_it.dart';

import 'home_bloc.dart';
import 'home_view.dart';

class HomeModule {
  static GetIt getIt = GetIt.instance;
  static configure() {
    getIt
      ..registerFactory<IHomeBloc>(() => HomeBloc(
            getIt(),
          ))
      ..registerFactory(() => HomeView(
            getIt(),
          ));
  }
}
