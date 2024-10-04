import 'package:escola/model/student_model.dart';
import 'package:escola/repository/rest_client/rest_client.dart';
import 'package:escola/repository/student_repository/student_repository.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  var student = StudentModel(id: 0, name: "Fernando Rodrigues Fernandes");
  final repository = StudentRepository(RestClient(), "http://localhost:8081");

  group('Testar CRUD completo com api real', () {
    StudentModel reponse = student;
    test("deve traser lista de cursos", () async {
      var result = await repository.getAll();
      print("Action [GetAll] --- Total register ${result.length}");
      expect(result.runtimeType, equals(List<StudentModel>));
    });
    test("deve registrar e confimar registro", () async {
      reponse = await repository.register(student);

      //Confimação do registro
      reponse = await repository.getById(reponse.id);
      print("Action [Create] --- ${reponse.id} --- ${reponse.name}");
      expect(reponse.name, student.name);
    });

    test("deve atualizar informações do curso", () async {
      int idComparison = reponse.id;
      reponse = await repository.update(StudentModel(
        id: idComparison,
        name: "natalia Daston",
      ));
      print("Action [Update] --- ${reponse.id} --- ${reponse.name}");
      //Confimação do registro
      final reponseComparison = await repository.getById(reponse.id);

      expect(reponse.id, idComparison);
      expect(reponse.name, reponseComparison.name);
    });

    test("deve deve deletar", () async {
      await repository.delete(reponse.id);
      bool existsCourse = false;
      try {
        reponse = await repository.getById(reponse.id);
      } catch (e) {
        existsCourse = true;
      }

      print("Action [Delete]");
      expect(existsCourse, true);
    });
  });
}
