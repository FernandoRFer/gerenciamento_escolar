import 'package:gerenciamento_escolar/view/course_forms/course_forms_bloc.dart';
import 'package:gerenciamento_escolar/view/course_forms/course_forms_view.dart';
import 'package:get_it/get_it.dart';

class CourseFormsModule {
  static GetIt getIt = GetIt.instance;
  static configure() {
    getIt
      ..registerFactory<ICourseCreateBloc>(() => CourseFormsBloc(
            getIt(),
            getIt(),
          ))
      ..registerFactory(() => CourseFormsView(
            getIt(),
          ));
  }
}
