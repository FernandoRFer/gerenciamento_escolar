import 'dart:async';

import 'package:gerenciamento_escolar/core/navigator/navigator_app.dart';
import 'package:gerenciamento_escolar/core/router/routes.dart';
import 'package:rxdart/rxdart.dart';

class HomeStatesBloc {}

abstract class IHomeBloc {
  Stream<HomeStatesBloc> get onFetchingData;
  Future<void> load();
  void navigatorPop();
  Future<void> dispose();
  Future<void> navigatorCourse();
  Future<void> navigatorStudents();
  Future<void> navigatorEnrollment();
}

class HomeBloc implements IHomeBloc {
  final INavigatorApp _navigatorApp;

  HomeBloc(
    this._navigatorApp,
  );

  final _fetchingDataController = BehaviorSubject<HomeStatesBloc>();

  @override
  Stream<HomeStatesBloc> get onFetchingData => _fetchingDataController.stream;

  @override
  Future<void> dispose() async {
    await _fetchingDataController.close();
  }

  @override
  Future<void> load() async {
    try {
      _fetchingDataController.add(HomeStatesBloc());
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
  Future<void> navigatorCourse() async {
    await _navigatorApp.pushNamed(AppRoutes.course);
  }

  @override
  Future<void> navigatorStudents() async {
    await _navigatorApp.pushNamed(AppRoutes.student);
  }

  @override
  Future<void> navigatorEnrollment() async {
    await _navigatorApp.pushNamed(AppRoutes.enrollment);
  }
}
