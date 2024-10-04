import 'package:escola/view/course/course_module.dart';
import 'package:escola/view/course_details/course_details_module.dart';
import 'package:escola/view/enrollment/enrollment_module.dart';
import 'package:escola/view/home/home_module.dart';
import 'package:escola/view/splash/splash_module.dart';
import 'package:escola/view/student_details/student_details_module.dart';
import 'package:escola/view/students/students_module.dart';

class ViewModule {
  static configure() {
    SplashModule.configure();
    HomeModule.configure();
    CourseModule.configure();
    CourseDetailsModule.configure();
    StudentModule.configure();
    StudentDetailsModule.configure();
    EnrollmentModule.configure();
  }
}
