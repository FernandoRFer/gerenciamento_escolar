import 'package:get_it/get_it.dart';

import 'course_bloc.dart';
import 'course_view.dart';

class CourseModule {
  static GetIt getIt = GetIt.instance;
  static configure() {
    getIt
      ..registerFactory<ICourseBloc>(() => CourseBloc(
            getIt(),
            getIt(),
          ))
      ..registerFactory(() => CourseView(
            getIt(),
          ));
  }
}
