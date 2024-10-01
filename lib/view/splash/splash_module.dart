import 'package:get_it/get_it.dart';
import '../../view/splash/splash_bloc.dart';
import '../../view/splash/splash_view.dart';

class SplashModule {
  static GetIt getIt = GetIt.instance;
  static configure() {
    getIt
      ..registerLazySingleton<ISplashBloc>(() => SplashBloc(
            getIt(),
          ))
      ..registerSingleton(() => SplashView(getIt()));
  }
}
