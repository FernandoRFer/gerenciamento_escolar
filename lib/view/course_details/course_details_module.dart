import 'package:escola/view/course_details/course_details_bloc.dart';
import 'package:escola/view/course_details/course_details_view.dart';
import 'package:get_it/get_it.dart';

class CourseDetailsModule {
  static GetIt getIt = GetIt.instance;
  static configure() {
    getIt
      ..registerFactory<ICourseDetailsBloc>(() => CourseDetailsBloc(
            getIt(),
            getIt(),
            getIt(),
          ))
      ..registerFactory(() => CourseDetailsView(
            getIt(),
          ));
  }
}
