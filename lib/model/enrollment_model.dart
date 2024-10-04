import 'package:gerenciamento_escolar/model/course_model.dart';
import 'package:gerenciamento_escolar/model/student_model.dart';

class EnrollmentModel {
  int id;
  StudentModel student;
  CourseModel course;

  EnrollmentModel({
    required this.id,
    required this.student,
    required this.course,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'student': student,
      'course': course,
    };
  }

  factory EnrollmentModel.fromJson(Map<String, dynamic> json) {
    return EnrollmentModel(
      id: json['codigo'] ?? 0,
      student: json['student'] ?? 0,
      course: json['course'] ?? 0,
    );
  }
}
