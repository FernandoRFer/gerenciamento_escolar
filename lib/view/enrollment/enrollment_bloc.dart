// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:rxdart/rxdart.dart';

import 'package:gerenciamento_escolar/core/navigator/navigator_app.dart';
import 'package:gerenciamento_escolar/core/router/routes.dart';
import 'package:gerenciamento_escolar/model/course_model.dart';
import 'package:gerenciamento_escolar/model/enrollment_model.dart';
import 'package:gerenciamento_escolar/model/student_model.dart';
import 'package:gerenciamento_escolar/repository/couse_repository/i_course_repository.dart';
import 'package:gerenciamento_escolar/repository/enrollment_repository/i_enrollment_repository.dart';
import 'package:gerenciamento_escolar/repository/student_repository/i_student_repository.dart';

abstract class EnrollmentStates {}

class InitialStates extends EnrollmentStates {}

class SuccesStates extends EnrollmentStates {
  String successInformation;
  SuccesStates(
    this.successInformation,
  );
}

class LoadingEnrollmentStates extends EnrollmentStates {
  String title;
  LoadingEnrollmentStates({this.title = "Carregando cursos"});
}

class SelectStudentEnrollmentStates extends EnrollmentStates {
  List<StudentModel> students;
  String search;
  SelectStudentEnrollmentStates({this.students = const [], this.search = ""});
}

class SelectCourseEnrollmentStates extends EnrollmentStates {
  List<CourseModel> courses;
  SelectCourseEnrollmentStates({this.courses = const []});
}

abstract class IEnrollmentBloc {
  Stream<EnrollmentStates> get onFetchingData;
  Stream<CourseModel?> get courseController;
  Stream<StudentModel> get studentController;
  Future<void> register();
  void navigatorPop();
  Future<void> dispose();
  Future<void> studentCreate();

  Future<void> studentSelection();
  Future<void> selectedStudent(StudentModel studentModel);
  Future<void> search(String? search);
  Future<void> claenSearch();

  void Function(CourseModel?) get changeCuorse;
  void Function(StudentModel) get changeStudent;
}

class EnrollmentBloc implements IEnrollmentBloc {
  final INavigatorApp _navigatorApp;
  final ICourseRepository _courseRepository;
  final IEnrollmentRepository _enrollmentRepository;
  final IStudentRepository _studentRepository;
  EnrollmentBloc(
    this._navigatorApp,
    this._courseRepository,
    this._enrollmentRepository,
    this._studentRepository,
  );

  final _fetchingDataController = BehaviorSubject<EnrollmentStates>();
  final _cuorseController = BehaviorSubject<CourseModel?>();
  final _studentController = BehaviorSubject<StudentModel>();

  List<StudentModel> _students = [];

  @override
  Stream<EnrollmentStates> get onFetchingData => _fetchingDataController.stream;
  @override
  Stream<CourseModel?> get courseController => _cuorseController.stream;
  @override
  Stream<StudentModel> get studentController => _studentController.stream;

  @override
  void Function(CourseModel?) get changeCuorse => _cuorseController.add;
  @override
  void Function(StudentModel) get changeStudent => _studentController.add;

  @override
  Future<void> dispose() async {
    await _fetchingDataController.close();
  }

  Future<void> selectStudent() async {
    try {
      _fetchingDataController.add(LoadingEnrollmentStates());
      final result = await _studentRepository.getAll();

      _fetchingDataController
          .add(SelectStudentEnrollmentStates(students: result));
    } catch (e) {
      _fetchingDataController.addError(
        e,
      );
    }
  }

  Future<void> loadCourse() async {
    try {
      _fetchingDataController.add(LoadingEnrollmentStates());
      final result = await _courseRepository.getAll();

      _fetchingDataController
          .add(SelectCourseEnrollmentStates(courses: result));
    } catch (e) {
      _fetchingDataController.addError(
        e,
      );
    }
  }

  @override
  Future<void> studentSelection() async {
    try {
      _fetchingDataController.add(LoadingEnrollmentStates());
      _students = await _studentRepository.getAll();

      _fetchingDataController
          .add(SelectStudentEnrollmentStates(students: _students));
    } catch (e) {
      _fetchingDataController.addError(
        e,
      );
    }
  }

  @override
  Future<void> selectedStudent(StudentModel studentModel) async {
    try {
      _fetchingDataController.add(LoadingEnrollmentStates());
      changeStudent(studentModel);
      loadCourse();
    } catch (e) {
      _fetchingDataController.addError(e);
    }
  }

  @override
  Future<void> search(String? search) async {
    if (search != null) {
      final result = _students
          .where((e) => e.name.toLowerCase().contains(search))
          .toList();
      _fetchingDataController
          .add(SelectStudentEnrollmentStates(students: result, search: search));
    } else {
      _fetchingDataController
          .add(SelectStudentEnrollmentStates(students: _students));
    }
  }

  @override
  Future<void> claenSearch() async {
    _fetchingDataController.add(SelectStudentEnrollmentStates(
      students: _students,
    ));
  }

  @override
  Future<void> studentCreate() async {
    try {
      _fetchingDataController.add(LoadingEnrollmentStates());
      final result = await _navigatorApp.pushNamed(AppRoutes.studentForms)
          as StudentModel?;
      if (result != null) {
        changeStudent(result);
        loadCourse();
        return;
      }
      _fetchingDataController.add(InitialStates());
    } catch (e) {
      _fetchingDataController.addError(e);
    }
  }

  @override
  Future<void> register() async {
    try {
      _fetchingDataController.add(LoadingEnrollmentStates());
      if (_cuorseController.value == null) {
        throw Exception(
            "Correu um erro ao carregar informações do curso, tente novamente!");
      }

      await _enrollmentRepository.register(EnrollmentModel(
          id: 0,
          student: (_studentController.value),
          course: _cuorseController.value!));

      _fetchingDataController
          .add(SuccesStates("Aluno matriculado com sucesso!"));
    } catch (e) {
      _fetchingDataController.addError(e);
    }
  }

  @override
  void navigatorPop() {
    _navigatorApp.pop();
  }
}
