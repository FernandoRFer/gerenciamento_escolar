import 'dart:async';
import 'package:escola/model/enrolled_course_detalis_model.dart';
import 'package:escola/model/enrolled_student.dart';
import 'package:escola/repository/couse_repository/i_course_repository.dart';
import 'package:escola/repository/matriculas_repository/i_student_repository.dart';
import 'package:rxdart/rxdart.dart';

import 'package:escola/core/router/navigator_app.dart';
import 'package:escola/model/course_model.dart';

abstract class CourseDetailsStates {}

class LoadingCourseDetailsStates extends CourseDetailsStates {
  String title;
  LoadingCourseDetailsStates({
    this.title = "Carregando cursos",
  });
}

class CourseDetailsModelBloc extends CourseDetailsStates {
  CourseModel course;
  List<EnrolledStudent> studants;
  CourseDetailsModelBloc({
    required this.course,
    required this.studants,
  });
}

abstract class ICourseDetailsBloc {
  Stream<CourseDetailsStates> get onFetchingData;
  Future<void> load();
  Future<void> retrievingArgument(CourseModel? course);
  void navigatorPop();
  Future<void> dispose();
  Future<void> update(CourseModel course);
  Future<void> deleteEnrollment(int idEnrolled);
  Future<void> deleteStuderd();
}

class CourseDetailsBloc implements ICourseDetailsBloc {
  final INavigatorApp _navigatorApp;
  final IEnrollmentRepository _enrollmentRepository;
  final ICourseRepository _courseRepository;
  CourseDetailsBloc(
    this._navigatorApp,
    this._enrollmentRepository,
    this._courseRepository,
  );

  final _fetchingDataController = BehaviorSubject<CourseDetailsStates>();
  CourseModel _course = CourseModel(codigo: 0, descricao: '', ementa: '');
  List<EnrolledStudent> _listCourses = <EnrolledStudent>[];

  @override
  Future<void> dispose() async {
    await _fetchingDataController.close();
  }

  @override
  Future<void> retrievingArgument(CourseModel? course) async {
    try {
      _fetchingDataController.add(LoadingCourseDetailsStates());
      if (course == null) {
        _fetchingDataController.addError(
          "Erro ao carregar detalhes da seleção",
        );
        return;
      }
      _course = course;
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
      _fetchingDataController.add(LoadingCourseDetailsStates());
      _listCourses =
          await _enrollmentRepository.getDetailsCourse(_course.codigo);

      _fetchingDataController
          .add(CourseDetailsModelBloc(course: _course, studants: _listCourses));
    } catch (e) {
      _fetchingDataController.addError(
        e,
      );
    }
  }

  @override
  Future<void> deleteEnrollment(int idEnrolled) async {
    try {
      _fetchingDataController.add(LoadingCourseDetailsStates());
      await _enrollmentRepository.deleteEnrolled(idEnrolled);
      await load();
    } catch (e) {
      _fetchingDataController.addError(
        e,
      );
    }
  }

  @override
  Future<void> update(CourseModel course) async {
    try {
      _fetchingDataController.add(LoadingCourseDetailsStates());
      _courseRepository.update(course);
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
  Stream<CourseDetailsStates> get onFetchingData =>
      _fetchingDataController.stream;

  @override
  Future<void> deleteStuderd() async {
    try {
      _fetchingDataController.add(LoadingCourseDetailsStates());
      await _courseRepository.delete(_course);
      navigatorPop();
    } catch (e) {
      _fetchingDataController.addError(
        e,
      );
    }
  }
}
