import 'dart:async';

import 'package:escola/model/enrolled_couse.dart';
import 'package:rxdart/rxdart.dart';

import 'package:escola/core/router/navigator_app.dart';
import 'package:escola/model/student_model.dart';
import 'package:escola/repository/matriculas_repository/i_student_repository.dart';
import 'package:escola/repository/student_repository/i_student_repository.dart';

abstract class StudentDetailsStates {}

class LoadingStudentDetailsStates extends StudentDetailsStates {
  String title;
  LoadingStudentDetailsStates({
    this.title = "Carregando cursos",
  });
}

class StudentDetailsModelBloc extends StudentDetailsStates {
  StudentModel student;
  List<EnrolledCourse> courses;
  StudentDetailsModelBloc({
    required this.student,
    required this.courses,
  });
}

abstract class IStudentDetailsBloc {
  Stream<StudentDetailsStates> get onFetchingData;
  Future<void> load();
  Future<void> retrievingArgument(StudentModel? student);
  void navigatorPop();
  Future<void> dispose();
  Future<void> update(StudentModel student);
  Future<void> deleteEnrollment(int idEnrolled);
  Future<void> deleteStuderd();
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

  final _fetchingDataController = BehaviorSubject<StudentDetailsStates>();
  StudentModel _student = StudentModel(nome: '', codigo: 0);
  List<EnrolledCourse> _listCourses = <EnrolledCourse>[];

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
      _student = student;
      await load();
    } catch (e) {
      _fetchingDataController.addError(
        e,
      );
    }
  }

  @override
  Future<void> load() async {
    try {
      _fetchingDataController.add(LoadingStudentDetailsStates());
      _listCourses =
          await _enrollmentRepository.getDetailsStudent(_student.codigo);

      _fetchingDataController.add(
          StudentDetailsModelBloc(student: _student, courses: _listCourses));
    } catch (e) {
      _fetchingDataController.addError(
        e,
      );
    }
  }

  @override
  Future<void> deleteEnrollment(int idEnrolled) async {
    try {
      _fetchingDataController.add(LoadingStudentDetailsStates());
      await _enrollmentRepository.deleteEnrolled(idEnrolled);
      await load();
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
      await load();
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
  Stream<StudentDetailsStates> get onFetchingData =>
      _fetchingDataController.stream;

  @override
  Future<void> deleteStuderd() async {
    try {
      _fetchingDataController.add(LoadingStudentDetailsStates());
      await _studentRepository.delete(_student);
      navigatorPop();
    } catch (e) {
      _fetchingDataController.addError(
        e,
      );
    }
  }
}
