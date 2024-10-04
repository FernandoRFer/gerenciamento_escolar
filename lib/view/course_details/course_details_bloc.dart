// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:gerenciamento_escolar/core/router/routes.dart';
import 'package:gerenciamento_escolar/view/course_forms/course_forms_view.dart';
import 'package:rxdart/rxdart.dart';

import 'package:gerenciamento_escolar/core/navigator/navigator_app.dart';
import 'package:gerenciamento_escolar/model/course_model.dart';
import 'package:gerenciamento_escolar/model/student_model.dart';
import 'package:gerenciamento_escolar/repository/couse_repository/i_course_repository.dart';
import 'package:gerenciamento_escolar/repository/enrollment_repository/i_enrollment_repository.dart';

abstract class CourseDetailsStates {}

class DeletedCoursetStates extends CourseDetailsStates {}

class UpdatesCoursetStates extends CourseDetailsStates {
  String updateInformation;
  UpdatesCoursetStates(
    this.updateInformation,
  );
}

class LoadingCourseDetailsStates extends CourseDetailsStates {
  String title;
  LoadingCourseDetailsStates({
    this.title = "Carregando cursos",
  });
}

class CourseDetailsModelBloc extends CourseDetailsStates {
  CourseModel course;
  List<StudentModel> students;
  CourseDetailsModelBloc({
    required this.course,
    required this.students,
  });

  CourseDetailsModelBloc copyWith({
    CourseModel? course,
    List<StudentModel>? students,
  }) {
    return CourseDetailsModelBloc(
      course: course ?? this.course,
      students: students ?? this.students,
    );
  }
}

abstract class ICourseDetailsBloc {
  Stream<CourseDetailsStates> get onFetchingData;
  void navigatorPop();
  Future<void> dispose();
  Future<void> retrievingArgument(CourseModel? course);
  Future<void> recharge();
  Future<void> update();
  Future<void> deleteEnrollment(StudentModel idEnrollment);
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
    students: <StudentModel>[],
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

      final students = await _enrollmentRepository.getDetailsCourse(course.id);

      _courseDetails =
          CourseDetailsModelBloc(course: course, students: students);

      _fetchingDataController.add(_courseDetails);
    } catch (e) {
      _fetchingDataController.addError(
        e,
      );
    }
  }

  @override
  Future<void> recharge() async {
    try {
      _fetchingDataController.add(LoadingCourseDetailsStates());
      final courses = await _courseRepository.getById(_courseDetails.course.id);
      final students = await _enrollmentRepository
          .getDetailsCourse(_courseDetails.course.id);
      _courseDetails =
          CourseDetailsModelBloc(students: students, course: courses);
      _fetchingDataController.add(_courseDetails);
    } catch (e) {
      _fetchingDataController.addError(
        e,
      );
    }
  }

  @override
  Future<void> update() async {
    try {
      _fetchingDataController.add(LoadingCourseDetailsStates());
      await _navigatorApp.pushNamed(AppRoutes.courseForms,
          arguments: CourseFormsViewArguments(course: _courseDetails.course));

      recharge();
    } catch (e) {
      _fetchingDataController.addError(
        e,
      );
    }
  }

  @override
  Future<void> deleteEnrollment(StudentModel student) async {
    try {
      _fetchingDataController.add(LoadingCourseDetailsStates());
      await _enrollmentRepository.deleteEnrollment(
          student.id, _courseDetails.course.id);

      _courseDetails.students = await _enrollmentRepository
          .getDetailsCourse(_courseDetails.course.id);

      _fetchingDataController.add(UpdatesCoursetStates(
          "Matricula do aluno \"${student.name}\" foi cancelada!"));
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

      _fetchingDataController.add(DeletedCoursetStates());
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
