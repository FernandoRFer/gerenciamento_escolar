import 'package:escola/model/course_model.dart';
import 'package:escola/model/enrolled_couse.dart';
import 'package:escola/model/enrolled_student.dart';
import 'package:escola/model/enrollment_model.dart';

abstract class IEnrollmentRepository {
  Future<List<CourseModel>> getId(int idStudent);
  Future<void> register(EnrollmentModel enrollment);
  Future<List<EnrolledCourse>> getDetailsStudent(int idStudent);
  Future<List<EnrolledStudent>> getDetailsCourse(int idCourse);
  Future<void> deleteEnrolled(int idEnrolled);
}
