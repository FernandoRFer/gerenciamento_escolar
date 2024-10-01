import 'package:escola/model/course_model.dart';
import 'package:escola/model/enrolled_couse.dart';
import 'package:escola/model/enrolled_student.dart';
import 'package:escola/model/enrollment_model.dart';
import 'package:escola/repository/couse_repository/mock_course.dart';
import 'package:escola/repository/matriculas_repository/i_student_repository.dart';
import 'package:escola/repository/student_repository/mock_student.dart';

class MockEnrollment implements IEnrollmentRepository {
  @override
  Future<void> deleteEnrolled(int idEnrolled) async {
    listEnrollment.removeWhere((e) => e.codigo == idEnrolled);
  }

  @override
  Future<void> register(EnrollmentModel enrollment) async {
    final searchMEnrollment = listEnrollment.any((e) =>
        e.course == enrollment.course && e.student == enrollment.student);
    if (searchMEnrollment) {
      throw (Exception(
          "Não é possivel matricular o alunos duas vezes no mesmo curso"));
    }
    listEnrollment.add(enrollment);
  }

  @override
  Future<List<EnrolledCourse>> getDetailsStudent(int idStudent) async {
    final courses = <EnrolledCourse>[];

    for (var enrollment in listEnrollment) {
      if (enrollment.student == idStudent) {
        final course =
            listCourseModel.firstWhere((e) => e.codigo == enrollment.course);
        courses
            .add(EnrolledCourse(idEnrolled: enrollment.codigo, course: course));
      }
    }

    return courses;
  }

  @override
  Future<List<CourseModel>> getId(int idStudent) {
    // TODO: implement getId
    throw UnimplementedError();
  }

  @override
  Future<List<EnrolledStudent>> getDetailsCourse(int idCourse) async {
    final students = <EnrolledStudent>[];

    for (var enrollment in listEnrollment) {
      if (enrollment.codigo == idCourse) {
        final result =
            listStudents.firstWhere((e) => e.codigo == enrollment.course);
        students.add(
            EnrolledStudent(idEnrolled: enrollment.codigo, student: result));
      }
    }

    return students;
  }
}

var listEnrollment = [
  EnrollmentModel(
    codigo: 2,
    student: 1,
    course: 3,
  ),
  EnrollmentModel(
    codigo: 3,
    student: 1,
    course: 1,
  ),
  EnrollmentModel(
    codigo: 4,
    student: 1,
    course: 2,
  ),
  EnrollmentModel(
    codigo: 5,
    student: 2,
    course: 1,
  ),
];
