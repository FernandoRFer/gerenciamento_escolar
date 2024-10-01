// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:escola/model/student_model.dart';
import 'package:escola/model/course_model.dart';

class EnrollmentModel {
  int codigo;
  int student;
  int course;

  EnrollmentModel({
    required this.codigo,
    required this.student,
    required this.course,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'codigo': codigo,
      'student': student,
      'course': course,
    };
  }

  factory EnrollmentModel.fromJson(Map<String, dynamic> json) {
    return EnrollmentModel(
      codigo: json['codigo'] ?? 0,
      student: json['student'] ?? 0,
      course: json['course'] ?? 0,
    );
  }
}
