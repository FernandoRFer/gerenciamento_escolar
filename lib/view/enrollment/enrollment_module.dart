import 'package:get_it/get_it.dart';

import 'enrollment_bloc.dart';
import 'enrollment_view.dart';

class EnrollmentModule {
  static GetIt getIt = GetIt.instance;
  static configure() {
    getIt
      ..registerFactory<IEnrollmentBloc>(() => EnrollmentBloc(
            getIt(),
          ))
      ..registerFactory(() => EnrollmentView(
            getIt(),
          ));
  }
}
