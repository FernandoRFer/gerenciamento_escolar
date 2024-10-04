import 'package:gerenciamento_escolar/model/course_model.dart';
import 'package:gerenciamento_escolar/model/enrollment_model.dart';
import 'package:gerenciamento_escolar/model/student_model.dart';
import 'package:gerenciamento_escolar/repository/enrollment_repository/i_enrollment_repository.dart';
import 'package:gerenciamento_escolar/core/utils/mocks/mock_data.dart';

class MockEnrollment implements IEnrollmentRepository {
  @override
  Future<List<CourseModel>> getId(int idStudent) {
    // TODO: implement getId
    throw UnimplementedError();
  }

  @override
  Future<List<CourseModel>> getDetailsStudent(int idStudent) async {
    final courses = <CourseModel>[];

    for (var enrollment in listEnrollment) {
      if (enrollment.student.id == idStudent) {
        final course =
            listCourseModel.firstWhere((e) => e.id == enrollment.course.id);
        courses.add(course);
      }
    }

    return courses;
  }

  @override
  Future<List<StudentModel>> getDetailsCourse(int idCourse) async {
    final students = <StudentModel>[];

    for (var enrollment in listEnrollment) {
      if (enrollment.course.id == idCourse) {
        final result =
            listStudents.firstWhere((e) => e.id == enrollment.student.id);
        students.add(result);
      }
    }
    return students;
  }

  @override
  Future<void> deleteEnrollment(int idStudent, int idCourse) async {
    listEnrollment.removeWhere(
        (e) => e.course.id == idCourse && e.student.id == idStudent);
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
}
