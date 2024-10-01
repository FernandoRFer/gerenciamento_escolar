import 'package:escola/view/course/course_view.dart';
import 'package:escola/view/course_details/course_details_view.dart';
import 'package:escola/view/home/home_view.dart';
import 'package:escola/view/matricula/matricula_view.dart';
import 'package:escola/view/splash/splash_bloc.dart';
import 'package:escola/view/splash/splash_view.dart';
import 'package:escola/view/student_details/student_details_view.dart';
import 'package:escola/view/students/students_view.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class AppRoutes {
  static const String initial = splash;
  static const String home = "/home";
  static const String register = "/register";
  static const String splash = "/splash";
  static const String matriculaView = "/matricula";
  static const String course = "/course";
  static const String courseDetails = "/courseDetails";
  static const String student = "/student";
  static const String studentDetails = "/studentDetails";

  static GetIt getIt = GetIt.I;

  static Map<String, WidgetBuilder> get routes => {
        splash: (_) => SplashView(getIt.get<ISplashBloc>()),
        home: (_) => getIt.get<HomeView>(),
        course: (_) => getIt.get<CourseView>(),
        matriculaView: (_) => const MatriculaView(),
        student: (_) => getIt.get<StudentView>(),
        studentDetails: (_) => getIt.get<StudentDetailsView>(),
        courseDetails: (_) => getIt.get<CourseDetailsView>()
      };
}
