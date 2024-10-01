import 'package:escola/model/course_model.dart';
import 'package:escola/model/enrolled_couse.dart';
import 'package:escola/model/student_model.dart';

class EnrolledStudentDetailsModel {
  StudentModel student;
  List<EnrolledCourse> course;

  EnrolledStudentDetailsModel({
    required this.student,
    required this.course,
  });

  factory EnrolledStudentDetailsModel.fromJson(Map<String, dynamic> json) {
    return EnrolledStudentDetailsModel(
        student: StudentModel.fromJson(json['student']),
        course: json['course'] == null
            ? []
            : json['course'].map(
                (e) => StudentModel.fromJson(json['student']),
              ));
  }
}
