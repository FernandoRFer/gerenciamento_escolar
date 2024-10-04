import 'package:gerenciamento_escolar/repository/couse_repository/i_course_repository.dart';
import 'package:gerenciamento_escolar/repository/couse_repository/mock_course.dart';
import 'package:gerenciamento_escolar/repository/enrollment_repository/i_enrollment_repository.dart';
import 'package:gerenciamento_escolar/repository/enrollment_repository/mock_student.dart';
import 'package:gerenciamento_escolar/repository/rest_client/irest_client.dart';
import 'package:gerenciamento_escolar/repository/rest_client/rest_client.dart';
import 'package:gerenciamento_escolar/repository/student_repository/i_student_repository.dart';
import 'package:gerenciamento_escolar/repository/student_repository/mock_student.dart';
import 'package:gerenciamento_escolar/core/utils/request_settings.dart';

import 'package:get_it/get_it.dart';

class RepositoryModule {
  static GetIt getIt = GetIt.instance;

  final _isMock = RequestSettings.isMock;
  static configure() {
    getIt
      ..registerLazySingleton<ICourseRepository>(() => MockCourse())
      ..registerLazySingleton<IStudentRepository>(() => MockStudent())
      ..registerLazySingleton<IEnrollmentRepository>(() => MockEnrollment())
      ..registerLazySingleton<IRestClient>(() => RestClient());
  }
}
