import 'dart:async';

import 'package:escola/core/router/routes.dart';
import 'package:rxdart/rxdart.dart';

import 'package:escola/core/navigator/navigator_app.dart';

abstract class EnrollmentStates {}

class LoadingEnrollmentStates extends EnrollmentStates {
  String title;
  LoadingEnrollmentStates({
    this.title = "Carregando cursos",
  });
}

class EnrollmentModelBloc extends EnrollmentStates {}

abstract class IEnrollmentBloc {
  Stream<EnrollmentStates> get onFetchingData;
  Future<void> load();
  void navigatorPop();
  Future<void> dispose();
}

class EnrollmentBloc implements IEnrollmentBloc {
  final INavigatorApp _navigatorApp;

  EnrollmentBloc(
    this._navigatorApp,
  );

  final _fetchingDataController = BehaviorSubject<EnrollmentStates>();

  @override
  Stream<EnrollmentStates> get onFetchingData => _fetchingDataController.stream;

  @override
  Future<void> dispose() async {
    await _fetchingDataController.close();
  }

  @override
  Future<void> load() async {
    try {
      _fetchingDataController.add(LoadingEnrollmentStates());
    } catch (e) {
      _fetchingDataController.addError(
        e,
      );
    }
  }

  @override
  void navigatorPop() {}
}
