import 'package:escola/view/student_details/student_details_bloc.dart';
import 'package:escola/view/student_details/student_details_view.dart';
import 'package:get_it/get_it.dart';

class StudentDetailsModule {
  static GetIt getIt = GetIt.instance;
  static configure() {
    getIt
      ..registerFactory<IStudentDetailsBloc>(() => StudentDetailsBloc(
            getIt(),
            getIt(),
            getIt(),
          ))
      ..registerFactory(() => StudentDetailsView(
            getIt(),
          ));
  }
}
