import 'package:gerenciamento_escolar/model/student_model.dart';

abstract class IStudentRepository {
  Future<List<StudentModel>> getAll();
  Future<StudentModel> getById(int idStudend);
  Future<StudentModel> register(StudentModel student);
  Future<StudentModel> update(StudentModel student);
  Future<void> delete(int idstudent);
}
