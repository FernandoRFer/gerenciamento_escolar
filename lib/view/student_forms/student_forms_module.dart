import 'package:gerenciamento_escolar/view/student_forms/student_forms_view.dart';
import 'package:gerenciamento_escolar/view/student_forms/student_forms_bloc.dart';
import 'package:get_it/get_it.dart';

class StudentFormsModule {
  static GetIt getIt = GetIt.instance;
  static configure() {
    getIt
      ..registerFactory<IStudentFormBloc>(() => StudentFormsBloc(
            getIt(),
            getIt(),
          ))
      ..registerFactory(() => StudentFormsView(
            getIt(),
          ));
  }
}
