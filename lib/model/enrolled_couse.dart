import 'package:escola/model/course_model.dart';

class EnrolledCourse {
  int idEnrolled;
  CourseModel course;

  EnrolledCourse({required this.idEnrolled, required this.course});

  factory EnrolledCourse.fromJson(Map<String, dynamic> json) {
    return EnrolledCourse(
        idEnrolled: json['idEnrolled'] as int,
        course: json['course'] == null
            ? CourseModel(descricao: '', ementa: '', codigo: 0)
            : CourseModel.fromJson(json['course']));
  }
}
