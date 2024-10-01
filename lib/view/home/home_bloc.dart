import 'dart:async';
import 'dart:developer';
import 'package:escola/core/router/navigator_app.dart';
import 'package:escola/core/router/routes.dart';
import 'package:rxdart/rxdart.dart';

class HomeModelBloc {}

abstract class IHomeBloc {
  Stream<HomeModelBloc> get onFetchingData;
  Future<void> load();
  void navigatorPop();
  Future<void> dispose();
  Future<void> navigatorCourse();
  Future<void> navigatorStudents();
}

class HomeBloc implements IHomeBloc {
  final INavigatorApp _navigatorApp;

  HomeBloc(
    this._navigatorApp,
  );

  final _fetchingDataController = BehaviorSubject<HomeModelBloc>();
  final _userNameController = BehaviorSubject<String>();
  final userdddd = StreamController();

  @override
  Future<void> dispose() async {
    await _fetchingDataController.close();
    await _userNameController.close();
  }

  @override
  Future<void> load() async {
    try {} catch (e) {
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
  Stream<HomeModelBloc> get onFetchingData => _fetchingDataController.stream;
}
