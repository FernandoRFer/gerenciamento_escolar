import 'dart:async';
import 'package:gerenciamento_escolar/repository/couse_repository/i_course_repository.dart';
import 'package:rxdart/rxdart.dart';

import 'package:gerenciamento_escolar/core/navigator/navigator_app.dart';
import 'package:gerenciamento_escolar/model/course_model.dart';

enum ActionCourseForms { update, create }

abstract class CourseFormsStates {}

class LoadingCourseFormsStates extends CourseFormsStates {}

class CourseCreateStates extends CourseFormsStates {}

class SuccesStates extends CourseFormsStates {
  String successInformation;
  SuccesStates(
    this.successInformation,
  );
}

class CourseUpdateModelStates extends CourseFormsStates {
  CourseModel course;
  CourseUpdateModelStates(
    this.course,
  );
}

abstract class ICourseCreateBloc {
  Stream<CourseFormsStates> get onFetchingData;
  Stream<String> get descriptionController;
  Stream<String> get syllabusController;

  Future<void> load(CourseModel? courser);
  Future<void> dispose();
  Future<void> action(ActionCourseForms actionForms);
  void navigatorPop();

  void Function(String) get changeDescription;
  void Function(String) get changeSyllabus;
}

class CourseFormsBloc implements ICourseCreateBloc {
  final INavigatorApp _navigatorApp;
  final ICourseRepository _courseRepository;
  CourseFormsBloc(
    this._navigatorApp,
    this._courseRepository,
  );

  final _fetchingDataController = BehaviorSubject<CourseFormsStates>();
  final _descriptionController = BehaviorSubject<String>();
  final _syllabusController = BehaviorSubject<String>();

  @override
  Stream<String> get descriptionController => _descriptionController.stream;
  @override
  Stream<String> get syllabusController => _syllabusController.stream;

  @override
  Stream<CourseFormsStates> get onFetchingData =>
      _fetchingDataController.stream;

  @override
  Future<void> dispose() async {
    await _fetchingDataController.close();
    await _descriptionController.close();
    await _syllabusController.close();
  }

  @override
  void Function(String) get changeDescription => _descriptionController.add;
  @override
  void Function(String) get changeSyllabus => _syllabusController.add;

  @override
  void navigatorPop() {
    _navigatorApp.pop();
  }

  CourseModel _courser = CourseModel(id: 0, description: "", syllabus: "");

  @override
  Future<void> load(CourseModel? courser) async {
    try {
      _fetchingDataController.add(LoadingCourseFormsStates());
      if (courser != null) {
        _courser = courser;
        _descriptionController.add(courser.description);
        _syllabusController.add(courser.syllabus);
        _fetchingDataController.add(CourseUpdateModelStates(courser));
        return;
      }
      _fetchingDataController.add(CourseCreateStates());
    } catch (e) {
      _fetchingDataController.addError(e);
    }
  }

  @override
  Future<void> action(ActionCourseForms actionCourseForms) async {
    if (actionCourseForms == ActionCourseForms.create) {
      _create();
    } else {
      _update();
    }
  }

  Future<void> _create() async {
    try {
      _fetchingDataController.add(LoadingCourseFormsStates());
      await _courseRepository.register(CourseModel(
          id: 0,
          description: _descriptionController.value,
          syllabus: _syllabusController.value));

      _fetchingDataController.add(SuccesStates("Curso criado com sucesso!"));
    } catch (e) {
      _fetchingDataController.addError(e);
    }
  }

  Future<void> _update() async {
    try {
      _fetchingDataController.add(LoadingCourseFormsStates());

      await _courseRepository.update(CourseModel(
          id: _courser.id,
          description: _descriptionController.value,
          syllabus: _syllabusController.value));

      _fetchingDataController.add(SuccesStates("Atualizado com sucesso!"));
    } catch (e) {
      _fetchingDataController.addError(e);
    }
  }
}
