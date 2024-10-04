import 'package:gerenciamento_escolar/view/courses/course_module.dart';
import 'package:gerenciamento_escolar/view/course_details/course_details_module.dart';
import 'package:gerenciamento_escolar/view/course_forms/course_forms_module.dart';
import 'package:gerenciamento_escolar/view/enrollment/enrollment_module.dart';
import 'package:gerenciamento_escolar/view/home/home_module.dart';
import 'package:gerenciamento_escolar/view/splash/splash_module.dart';
import 'package:gerenciamento_escolar/view/student_details/student_details_module.dart';
import 'package:gerenciamento_escolar/view/student_forms/student_forms_module.dart';
import 'package:gerenciamento_escolar/view/students/students_module.dart';

class ViewModule {
  static configure() {
    SplashModule.configure();
    HomeModule.configure();

    CourseModule.configure();
    CourseDetailsModule.configure();
    CourseFormsModule.configure();

    StudentModule.configure();
    StudentDetailsModule.configure();
    StudentFormsModule.configure();

    EnrollmentModule.configure();
  }
}
