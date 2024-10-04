import 'package:escola/model/course_model.dart';
import 'package:escola/model/enrollment_model.dart';
import 'package:escola/model/student_model.dart';

abstract class IEnrollmentRepository {
  Future<void> register(EnrollmentModel enrollment);
  Future<List<CourseModel>> getDetailsStudent(int idStudent);
  Future<List<StudentModel>> getDetailsCourse(int idCourse);
  Future<void> deleteEnrollment(int idStudent, int idCourse);
}
