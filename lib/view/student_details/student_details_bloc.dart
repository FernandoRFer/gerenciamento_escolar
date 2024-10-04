import 'dart:async';

import 'package:rxdart/rxdart.dart';

import 'package:escola/core/navigator/navigator_app.dart';
import 'package:escola/model/course_model.dart';
import 'package:escola/model/student_model.dart';
import 'package:escola/repository/enrollment_repository/i_enrollment_repository.dart';
import 'package:escola/repository/student_repository/i_student_repository.dart';

abstract class StudentDetailsStates {}

class LoadingStudentDetailsStates extends StudentDetailsStates {
  String title;
  LoadingStudentDetailsStates({
    this.title = "Carregando cursos",
  });
}

class DeletedStudentStates extends StudentDetailsStates {}

class UpdateSuccesStudentStates extends StudentDetailsStates {
  String title;
  UpdateSuccesStudentStates(
    this.title,
  );
}

class StudentDetailsModelBloc extends StudentDetailsStates {
  StudentModel student;
  List<CourseModel> courses;
  StudentDetailsModelBloc({
    required this.student,
    required this.courses,
  });

  StudentDetailsModelBloc copyWith({
    StudentModel? student,
    List<CourseModel>? courses,
  }) {
    return StudentDetailsModelBloc(
      student: student ?? this.student,
      courses: courses ?? this.courses,
    );
  }
}

abstract class IStudentDetailsBloc {
  Stream<StudentDetailsStates> get onFetchingData;
  Future<void> retrievingArgument(StudentModel? student);
  void navigatorPop();
  Future<void> dispose();
  Future<void> update(StudentModel student);
  Future<void> deleteEnrollment(CourseModel idCourse);
  Future<void> deleteStuderd();
  Future<void> recharge();
}

class StudentDetailsBloc implements IStudentDetailsBloc {
  final INavigatorApp _navigatorApp;
  final IEnrollmentRepository _enrollmentRepository;
  final IStudentRepository _studentRepository;
  StudentDetailsBloc(
    this._navigatorApp,
    this._enrollmentRepository,
    this._studentRepository,
  );

  StudentDetailsModelBloc _studentDetails = StudentDetailsModelBloc(
    student: StudentModel(name: '', id: 0),
    courses: const [],
  );

  final _fetchingDataController = BehaviorSubject<StudentDetailsStates>();

  @override
  Stream<StudentDetailsStates> get onFetchingData =>
      _fetchingDataController.stream;

  @override
  Future<void> dispose() async {
    await _fetchingDataController.close();
  }

  @override
  Future<void> retrievingArgument(StudentModel? student) async {
    try {
      _fetchingDataController.add(LoadingStudentDetailsStates());
      if (student == null) {
        _fetchingDataController.addError(
          "Erro ao carregar detalhes da seleção",
        );
        return;
      }
      final courses = await _enrollmentRepository.getDetailsStudent(student.id);
      _studentDetails =
          _studentDetails.copyWith(student: student, courses: courses);
      _fetchingDataController.add(_studentDetails);
    } catch (e) {
      _fetchingDataController.addError(
        e,
      );
    }
  }

  @override
  Future<void> recharge() async {
    try {
      _fetchingDataController.add(LoadingStudentDetailsStates());
      final student =
          await _studentRepository.getById(_studentDetails.student.id);
      final courses = await _enrollmentRepository
          .getDetailsStudent(_studentDetails.student.id);
      _studentDetails =
          StudentDetailsModelBloc(student: student, courses: courses);
      _fetchingDataController.add(_studentDetails);
    } catch (e) {
      _fetchingDataController.addError(
        e,
      );
    }
  }

  @override
  Future<void> deleteEnrollment(CourseModel course) async {
    try {
      _fetchingDataController.add(LoadingStudentDetailsStates());
      await _enrollmentRepository.deleteEnrollment(
          _studentDetails.student.id, course.id);
      final courses = await _enrollmentRepository
          .getDetailsStudent(_studentDetails.student.id);
      _studentDetails.copyWith(courses: courses);
      _fetchingDataController.add(UpdateSuccesStudentStates(
          "Matricula do curso \"${course.description}\" foi cancelada!"));
    } catch (e) {
      _fetchingDataController.addError(
        e,
      );
    }
  }

  @override
  Future<void> update(StudentModel student) async {
    try {
      _fetchingDataController.add(LoadingStudentDetailsStates());
      _studentRepository.update(student);
      final courses = await _enrollmentRepository.getDetailsStudent(student.id);
      _studentDetails.copyWith(student: student, courses: courses);
      _fetchingDataController
          .add(UpdateSuccesStudentStates("Aluno excluido com sucesso!"));
    } catch (e) {
      _fetchingDataController.addError(
        e,
      );
    }
  }

  @override
  void navigatorPop() {
    _navigatorApp.pop();
  }

  @override
  Future<void> deleteStuderd() async {
    try {
      _fetchingDataController.add(LoadingStudentDetailsStates());
      await _studentRepository.delete(_studentDetails.student.id);

      _fetchingDataController.add(DeletedStudentStates());
    } catch (e) {
      _fetchingDataController.addError(
        e,
      );
    }
  }
}
