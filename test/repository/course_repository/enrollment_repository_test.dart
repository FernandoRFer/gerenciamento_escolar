import 'package:escola/model/course_model.dart';
import 'package:escola/model/enrollment_model.dart';
import 'package:escola/model/student_model.dart';
import 'package:escola/repository/couse_repository/course_repository.dart';
import 'package:escola/repository/enrollment_repository/enrollment_repository.dart';
import 'package:escola/repository/rest_client/rest_client.dart';
import 'package:escola/repository/student_repository/student_repository.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  final studentRepository =
      StudentRepository(RestClient(), "http://localhost:8081");
  final courseRepository =
      CourseRepository(RestClient(), "http://localhost:8081");

  late StudentModel student1;
  late StudentModel student2;

  late CourseModel course1;
  late CourseModel course2;

  final repository =
      EnrollmentRepository(RestClient(), "http://localhost:8081");

  group('Testar CRUD completo com api real', () {
    setUp(() async {
      student1 = await studentRepository
          .register(StudentModel(id: 0, name: "Maria fernanda "));
      student2 = await studentRepository
          .register(StudentModel(id: 0, name: "Natalia Daston"));
      course1 = await courseRepository.register(CourseModel(
          id: 0,
          description: "Fisioterapia",
          syllabus: "Fisioterapia e cuidado com os pacientes"));
      course2 = await courseRepository.register(CourseModel(
          id: 0,
          description: "Fisioterapia",
          syllabus: "Fisioterapia e cuidado com os pacientes"));

      await repository
          .register(EnrollmentModel(id: 0, student: student1, course: course1));
      await repository
          .register(EnrollmentModel(id: 0, student: student1, course: course2));
      await repository
          .register(EnrollmentModel(id: 0, student: student2, course: course1));
      await repository
          .register(EnrollmentModel(id: 0, student: student2, course: course2));
    });

    test("deve traser lista de cursos", () async {
      var results = await repository.getDetailsCourse(course1.id);
      for (var result in results) {
        print("Action [getDetailsCourse] --- ${result.id} --- ${result.name}");
      }
      expect(results.runtimeType, equals(List<StudentModel>));
    });

    test("deve traser lista de curso", () async {
      var results = await repository.getDetailsStudent(student1.id);
      for (var result in results) {
        print(
            "Action [getDetailsCourse] --- ${result.id} --- ${result.description}");
      }
      expect(results.runtimeType, equals(List<CourseModel>));
    });

    test("deve deve deletar", () async {
      print("${student1.id}, ${course1.id}");
      await repository.deleteEnrollment(student1.id, course1.id);

      print("Action [Delete] ");
    });
  });
}
