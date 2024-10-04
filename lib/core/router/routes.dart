import 'package:gerenciamento_escolar/view/courses/course_view.dart';
import 'package:gerenciamento_escolar/view/course_details/course_details_view.dart';
import 'package:gerenciamento_escolar/view/course_forms/course_forms_view.dart';
import 'package:gerenciamento_escolar/view/enrollment/enrollment_view.dart';
import 'package:gerenciamento_escolar/view/home/home_view.dart';

import 'package:gerenciamento_escolar/view/splash/splash_bloc.dart';
import 'package:gerenciamento_escolar/view/splash/splash_view.dart';
import 'package:gerenciamento_escolar/view/student_details/student_details_view.dart';
import 'package:gerenciamento_escolar/view/student_forms/student_forms_view.dart';
import 'package:gerenciamento_escolar/view/students/students_view.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class AppRoutes {
  static const String initial = splash;
  static const String home = "/home";
  static const String register = "/register";
  static const String splash = "/splash";
  static const String enrollment = "/matricula";

  static const String course = "/course";
  static const String courseDetails = "/courseDetails";
  static const String courseForms = "/courseForms";

  static const String student = "/student";
  static const String studentDetails = "/studentDetails";
  static const String studentForms = "/studentForms";

  static GetIt getIt = GetIt.I;

  static Map<String, WidgetBuilder> get routes => {
        splash: (_) => SplashView(getIt.get<ISplashBloc>()),
        home: (_) => getIt.get<HomeView>(),
        course: (_) => getIt.get<CourseView>(),
        enrollment: (_) => getIt.get<EnrollmentView>(),
        student: (_) => getIt.get<StudentView>(),
        studentDetails: (_) => getIt.get<StudentDetailsView>(),
        courseDetails: (_) => getIt.get<CourseDetailsView>(),
        courseForms: (_) => getIt.get<CourseFormsView>(),
        studentForms: (_) => getIt.get<StudentFormsView>(),
      };
}
