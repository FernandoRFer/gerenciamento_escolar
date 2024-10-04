// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:escola/core/router/routes.dart';
import 'package:escola/view/student_details/student_details_view.dart';
import 'package:rxdart/rxdart.dart';

import 'package:escola/core/navigator/navigator_app.dart';
import 'package:escola/model/student_model.dart';
import 'package:escola/repository/student_repository/i_student_repository.dart';

abstract class StudentStates {}

class LoadingStudentStates extends StudentStates {
  String title;
  LoadingStudentStates({
    this.title = "Carregando cursos",
  });
}

class StudentModelBloc extends StudentStates {
  List<StudentModel> students;
  String search;

  StudentModelBloc({
    this.students = const [],
    this.search = "",
  });
}

abstract class IStudentBloc {
  Stream<StudentStates> get onFetchingData;
  Future<void> load();
  void navigatorPop();
  Future<void> studentDetails(StudentModel studentSelect);
  Future<void> dispose();
  Future<void> search(String? search);
  Future<void> claenSearch();
}

class StudentBloc implements IStudentBloc {
  final INavigatorApp _navigatorApp;
  final IStudentRepository _studentRepository;

  StudentBloc(
    this._navigatorApp,
    this._studentRepository,
  );

  final _fetchingDataController = BehaviorSubject<StudentStates>();

  List<StudentModel> _students = [];

  @override
  Stream<StudentStates> get onFetchingData => _fetchingDataController.stream;

  @override
  Future<void> dispose() async {
    await _fetchingDataController.close();
  }

  @override
  Future<void> load() async {
    try {
      _fetchingDataController.add(LoadingStudentStates());

      _students = await _studentRepository.getAll();
      _fetchingDataController.add(StudentModelBloc(students: _students));
    } catch (e) {
      _fetchingDataController.addError(
        e,
      );
    }
  }

  @override
  Future<void> studentDetails(StudentModel studentSelect) async {
    await _navigatorApp
        .pushNamed(AppRoutes.studentDetails,
            arguments:
                StudentDetailsViewArguments(studentSelect: studentSelect))
        .then((_) {
      load();
    });
  }

  @override
  void navigatorPop() {
    _navigatorApp.pop();
  }

  @override
  Future<void> search(String? search) async {
    if (search != null) {
      final result = _students
          .where((e) => e.name.toLowerCase().contains(search))
          .toList();
      _fetchingDataController
          .add(StudentModelBloc(students: result, search: search));
    } else {
      _fetchingDataController.add(StudentModelBloc(students: _students));
    }
  }

  @override
  Future<void> claenSearch() async {
    _fetchingDataController.add(StudentModelBloc(
      students: _students,
    ));
  }
}
