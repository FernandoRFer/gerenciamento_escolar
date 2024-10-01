import 'package:escola/model/student_model.dart';
import 'package:escola/repository/student_repository/i_student_repository.dart';

class MockStudent implements IStudentRepository {
  @override
  Future<void> delete(StudentModel studentDelete) async {
    listStudents.removeWhere((e) => e.codigo == studentDelete.codigo);
  }

  @override
  Future<List<StudentModel>> getAll() async {
    return listStudents;
  }

  @override
  Future<void> register(StudentModel student) async {
    listStudents.add(student);
  }

  @override
  Future<StudentModel> update(StudentModel studentUpdate) async {
    for (int i = 0; i < listStudents.length; i++) {
      if (listStudents[i].codigo == studentUpdate.codigo) {
        listStudents[i] = studentUpdate;
        return listStudents[i];
      }
    }
    throw ("Não foi possivel atulizar o cadastro do Aluno.");
  }
}

final List<StudentModel> listStudents = [
  StudentModel(
    codigo: 1,
    nome: "Fernando Rodrigues",
  ),
  StudentModel(
    codigo: 2,
    nome: "Carlos Alberto",
  ),
  StudentModel(
    codigo: 3,
    nome: "Maria Fernando",
  ),
  StudentModel(
    codigo: 4,
    nome: "Natalia Dastons",
  ),
];
