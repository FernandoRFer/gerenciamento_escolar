import 'package:escola/repository/couse_repository/i_course_repository.dart';
import 'package:escola/repository/couse_repository/mock_course.dart';
import 'package:escola/repository/matriculas_repository/i_student_repository.dart';
import 'package:escola/repository/matriculas_repository/mock_student.dart';
import 'package:escola/repository/student_repository/i_student_repository.dart';
import 'package:escola/repository/student_repository/mock_student.dart';

import 'package:get_it/get_it.dart';

class RepositoryModule {
  static GetIt getIt = GetIt.instance;
  static configure() {
    getIt
      ..registerLazySingleton<ICourseRepository>(() => MockCourse())
      ..registerLazySingleton<IStudentRepository>(() => MockStudent())
      ..registerLazySingleton<IEnrollmentRepository>(() => MockEnrollment());
  }
}
