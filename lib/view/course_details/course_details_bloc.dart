import 'dart:async';
import 'package:rxdart/rxdart.dart';

import 'package:escola/core/navigator/navigator_app.dart';
import 'package:escola/model/course_model.dart';
import 'package:escola/model/student_model.dart';
import 'package:escola/repository/couse_repository/i_course_repository.dart';
import 'package:escola/repository/enrollment_repository/i_enrollment_repository.dart';

abstract class CourseDetailsStates {}

class LoadingCourseDetailsStates extends CourseDetailsStates {
  String title;
  LoadingCourseDetailsStates({
    this.title = "Carregando cursos",
  });
}

class CourseDetailsModelBloc extends CourseDetailsStates {
  CourseModel course;
  List<StudentModel> studants;
  CourseDetailsModelBloc({
    required this.course,
    required this.studants,
  });

  CourseDetailsModelBloc copyWith({
    CourseModel? course,
    List<StudentModel>? studants,
  }) {
    return CourseDetailsModelBloc(
      course: course ?? this.course,
      studants: studants ?? this.studants,
    );
  }
}

abstract class ICourseDetailsBloc {
  Stream<CourseDetailsStates> get onFetchingData;

  Future<void> retrievingArgument(CourseModel? course);
  void navigatorPop();
  Future<void> dispose();
  Future<void> update(CourseModel course);
  Future<void> deleteEnrollment(int idEnrollment);
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

  CourseDetailsModelBloc _courseDetails = CourseDetailsModelBloc(
    course: CourseModel(id: 0, description: '', syllabus: ''),
    studants: <StudentModel>[],
  );

  final _fetchingDataController = BehaviorSubject<CourseDetailsStates>();

  @override
  Stream<CourseDetailsStates> get onFetchingData =>
      _fetchingDataController.stream;

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

      final studants = await _enrollmentRepository.getDetailsCourse(course.id);

      _courseDetails =
          CourseDetailsModelBloc(course: course, studants: studants);

      _fetchingDataController.add(_courseDetails);
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
      await _courseRepository.update(course);

      _courseDetails.copyWith(course: course);

      _fetchingDataController.add(_courseDetails);
    } catch (e) {
      _fetchingDataController.addError(
        e,
      );
    }
  }

  @override
  Future<void> deleteEnrollment(int idStudent) async {
    try {
      _fetchingDataController.add(LoadingCourseDetailsStates());
      await _enrollmentRepository.deleteEnrollment(
          idStudent, _courseDetails.course.id);

      _courseDetails.studants = await _enrollmentRepository
          .getDetailsCourse(_courseDetails.course.id);

      _fetchingDataController.add(_courseDetails);
    } catch (e) {
      _fetchingDataController.addError(
        e,
      );
    }
  }

  @override
  Future<void> deleteStuderd() async {
    try {
      _fetchingDataController.add(LoadingCourseDetailsStates());
      await _courseRepository.delete(_courseDetails.course.id);

      _fetchingDataController.add(LoadingCourseDetailsStates());
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
}
