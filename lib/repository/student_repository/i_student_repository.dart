import 'package:escola/model/student_model.dart';

abstract class IStudentRepository {
  Future<List<StudentModel>> getAll();
  Future<void> register(StudentModel student);
  Future<StudentModel> update(StudentModel student);
  Future<void> delete(StudentModel student);
}
