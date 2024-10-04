import 'dart:async';
import 'package:gerenciamento_escolar/model/student_model.dart';
import 'package:gerenciamento_escolar/repository/couse_repository/i_course_repository.dart';
import 'package:gerenciamento_escolar/repository/student_repository/i_student_repository.dart';
import 'package:rxdart/rxdart.dart';

import 'package:gerenciamento_escolar/core/navigator/navigator_app.dart';
import 'package:gerenciamento_escolar/model/course_model.dart';

enum ActionStudentForms { update, create }

abstract class StudentFormsStates {}

class LoadingStudentFormsStates extends StudentFormsStates {}

class StudentCreateStates extends StudentFormsStates {}

class SuccesStates extends StudentFormsStates {
  String successInformation;
  SuccesStates(
    this.successInformation,
  );
}

class StudentUpdateModelStates extends StudentFormsStates {
  StudentModel student;
  StudentUpdateModelStates(
    this.student,
  );
}

abstract class IStudentFormBloc {
  Stream<StudentFormsStates> get onFetchingData;
  Stream<String> get nameController;

  Future<void> load(StudentModel? student);
  Future<void> dispose();
  Future<void> action(ActionStudentForms actionForms);
  void navigatorPop();
  void navigatorPopArgument();

  void Function(String) get changeName;
}

class StudentFormsBloc implements IStudentFormBloc {
  final INavigatorApp _navigatorApp;
  final IStudentRepository _studentRepository;
  StudentFormsBloc(
    this._navigatorApp,
    this._studentRepository,
  );

  final _fetchingDataController = BehaviorSubject<StudentFormsStates>();
  final _nameController = BehaviorSubject<String>();

  @override
  Stream<String> get nameController => _nameController.stream;

  @override
  Stream<StudentFormsStates> get onFetchingData =>
      _fetchingDataController.stream;

  @override
  Future<void> dispose() async {
    await _fetchingDataController.close();
    await _nameController.close();
  }

  @override
  void Function(String) get changeName => _nameController.add;

  @override
  void navigatorPop() {
    _navigatorApp.pop();
  }

  @override
  void navigatorPopArgument() {
    _navigatorApp.pop(_student);
  }

  StudentModel _student = StudentModel(id: 0, name: "");

  @override
  Future<void> load(StudentModel? student) async {
    try {
      _fetchingDataController.add(LoadingStudentFormsStates());
      if (student != null) {
        _student = student;
        _nameController.add(student.name);
        _fetchingDataController.add(StudentUpdateModelStates(student));
        return;
      }
      _fetchingDataController.add(StudentCreateStates());
    } catch (e) {
      _fetchingDataController.addError(e);
    }
  }

  @override
  Future<void> action(ActionStudentForms actionStudentForms) async {
    if (actionStudentForms == ActionStudentForms.create) {
      _create();
    } else {
      _update();
    }
  }

  Future<void> _create() async {
    try {
      _fetchingDataController.add(LoadingStudentFormsStates());
      _student = await _studentRepository
          .register(StudentModel(id: 0, name: _nameController.value));

      _fetchingDataController.add(SuccesStates("Aluno criado com sucesso!"));
    } catch (e) {
      _fetchingDataController.addError(e);
    }
  }

  Future<void> _update() async {
    try {
      _fetchingDataController.add(LoadingStudentFormsStates());

      await _studentRepository
          .update(StudentModel(id: _student.id, name: _nameController.value));

      _fetchingDataController
          .add(SuccesStates("Cadastro realizado com sucesso com sucesso!"));
    } catch (e) {
      _fetchingDataController.addError(e);
    }
  }
}
