import 'package:gerenciamento_escolar/model/course_model.dart';
import 'package:gerenciamento_escolar/model/enrollment_model.dart';
import 'package:gerenciamento_escolar/model/student_model.dart';

abstract class IEnrollmentRepository {
  Future<void> register(EnrollmentModel enrollment);
  Future<List<CourseModel>> getDetailsStudent(int idStudent);
  Future<List<StudentModel>> getDetailsCourse(int idCourse);
  Future<void> deleteEnrollment(int idStudent, int idCourse);
}
