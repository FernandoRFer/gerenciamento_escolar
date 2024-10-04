import 'package:gerenciamento_escolar/model/student_model.dart';
import 'package:gerenciamento_escolar/repository/student_repository/i_student_repository.dart';
import 'package:gerenciamento_escolar/core/utils/mocks/mock_data.dart';

class MockStudent implements IStudentRepository {
  @override
  Future<void> delete(int idStudent) async {
    listStudents.removeWhere((e) => e.id == idStudent);
  }

  @override
  Future<List<StudentModel>> getAll() async {
    return listStudents;
  }

  @override
  Future<StudentModel> register(StudentModel student) async {
    listStudents.add(student);
    return student;
  }

  @override
  Future<StudentModel> update(StudentModel studentUpdate) async {
    for (int i = 0; i < listStudents.length; i++) {
      if (listStudents[i].id == studentUpdate.id) {
        listStudents[i] = studentUpdate;
        return listStudents[i];
      }
    }
    throw ("Não foi possivel atualizar o cadastro do Aluno.");
  }

  @override
  Future<StudentModel> getById(int idStudend) async {
    for (var listStudent in listStudents) {
      if (listStudent.id == idStudend) {
        return listStudent;
      }
    }
    throw ("Não foi possivel atualizar o cadastro do Aluno.");
  }
}
