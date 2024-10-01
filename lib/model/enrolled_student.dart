import 'package:escola/model/student_model.dart';

class EnrolledStudent {
  int idEnrolled;
  StudentModel student;
  EnrolledStudent({
    required this.idEnrolled,
    required this.student,
  });

  factory EnrolledStudent.fromJson(Map<String, dynamic> json) {
    return EnrolledStudent(
      idEnrolled: json['idEnrolled'] as int,
      student: json['course'] == null
          ? StudentModel(codigo: 0, nome: '')
          : StudentModel.fromJson(json['course']),
    );
  }
}
