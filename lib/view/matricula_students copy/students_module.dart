import 'package:get_it/get_it.dart';

import 'students_bloc.dart';
import 'students_view.dart';

class StudentModule {
  static GetIt getIt = GetIt.instance;
  static configure() {
    getIt
      ..registerFactory<IStudentBloc>(() => StudentBloc(
            getIt(),
            getIt(),
          ))
      ..registerFactory(() => StudentView(
            getIt(),
          ));
  }
}
