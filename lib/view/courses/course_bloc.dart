import 'dart:async';
import 'package:rxdart/rxdart.dart';

import 'package:gerenciamento_escolar/core/router/routes.dart';
import 'package:gerenciamento_escolar/core/navigator/navigator_app.dart';
import 'package:gerenciamento_escolar/repository/couse_repository/i_course_repository.dart';
import 'package:gerenciamento_escolar/view/course_details/course_details_view.dart';
import 'package:gerenciamento_escolar/model/course_model.dart';

abstract class CourseStates {}

class LoadingCourseStates extends CourseStates {
  String title;
  LoadingCourseStates({
    this.title = "Carregando cursos",
  });
}

class CourseModelBloc extends CourseStates {
  List<CourseModel> courses;
  String search;
  CourseModelBloc({
    this.courses = const [],
    this.search = "",
  });
}

abstract class ICourseBloc {
  Stream<CourseStates> get onFetchingData;
  Future<void> load();
  void navigatorPop();
  Future<void> dispose();
  Future<void> update(CourseModel courseUpdate);
  Future<void> delete(CourseModel courseDelete);
  Future<void> studentDetails(CourseModel course);
  Future<void> search(String? search);
  Future<void> claenSearch();
  Future<void> navegateCourseCreate();
}

class CourseBloc implements ICourseBloc {
  final INavigatorApp _navigatorApp;
  final ICourseRepository _courseRepository;

  CourseBloc(
    this._navigatorApp,
    this._courseRepository,
  );

  final _fetchingDataController = BehaviorSubject<CourseStates>();

  List<CourseModel> _courses = [];

  @override
  Future<void> dispose() async {
    await _fetchingDataController.close();
  }

  @override
  Future<void> load() async {
    try {
      _fetchingDataController.add(LoadingCourseStates());

      _courses = await _courseRepository.getAll();
      _fetchingDataController.add(CourseModelBloc(courses: _courses));
    } catch (e) {
      _fetchingDataController.addError(
        e,
      );
    }
  }

  @override
  Future<void> studentDetails(CourseModel course) async {
    await _navigatorApp
        .pushNamed(AppRoutes.courseDetails,
            arguments: CourseDetailsViewArguments(courseSelect: course))
        .then((_) {
      load();
    });
  }

  @override
  Future<void> delete(CourseModel course) async {
    try {
      _fetchingDataController.add(LoadingCourseStates());
      await _courseRepository.delete(course.id);
      await load();
    } catch (e) {
      _fetchingDataController.addError(
        e,
      );
    }
  }

  @override
  Future<void> update(CourseModel courseUpdate) async {
    try {
      _fetchingDataController.add(LoadingCourseStates());
      await _courseRepository.update(courseUpdate);
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
  Stream<CourseStates> get onFetchingData => _fetchingDataController.stream;

  @override
  Future<void> search(String? search) async {
    if (search != null && search.isNotEmpty) {
      final result = _courses
          .where((e) => e.description.toLowerCase().contains(search))
          .toList();
      _fetchingDataController
          .add(CourseModelBloc(courses: result, search: search));
    } else {
      _fetchingDataController.add(CourseModelBloc(courses: _courses));
    }
  }

  @override
  Future<void> claenSearch() async {
    _fetchingDataController.add(CourseModelBloc(
      courses: _courses,
    ));
  }

  @override
  Future<void> navegateCourseCreate() async {
    await _navigatorApp.pushNamed(AppRoutes.courseForms).then((_) => load());
  }
}
