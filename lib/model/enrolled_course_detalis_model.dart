import 'package:escola/model/course_model.dart';
import 'package:escola/model/enrolled_student.dart';
import 'package:escola/model/student_model.dart';

class StudentDetailsModel {
  StudentModel course;
  List<EnrolledStudent> students;

  StudentDetailsModel({
    required this.course,
    required this.students,
  });

  factory StudentDetailsModel.fromJson(Map<String, dynamic> json) {
    return StudentDetailsModel(
      course: StudentModel.fromJson(json['student']),
      students: json['course'] == null
          ? []
          : json['course'].map(
              (e) => StudentModel.fromJson(json['student']),
            ),
    );
  }
}
