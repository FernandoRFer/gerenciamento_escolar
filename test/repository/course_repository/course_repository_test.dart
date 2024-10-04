import 'package:gerenciamento_escolar/model/course_model.dart';
import 'package:gerenciamento_escolar/repository/couse_repository/course_repository.dart';
import 'package:gerenciamento_escolar/repository/rest_client/rest_client.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  final repository = CourseRepository(RestClient(), "http://localhost:8081");

  group('Testar CRUD completo com api real', () {
    CourseModel reponse = course;
    //Carantir que não será alterado assim que criado
    late final int idComparison;
    test("deve traser lista de cursos", () async {
      var result = await repository.getAll();
      print("Action [GetAll] --- Total register ${result.length}");
      expect(result.runtimeType, equals(List<CourseModel>));
    });
    test("deve registrar e confimar registro", () async {
      reponse = await repository.register(course);

      //Salvando id para comparações futurar
      idComparison = reponse.id;

      //Confimação do registro
      reponse = await repository.getById(reponse.id);

      print(
          "Action [Create] --- ${reponse.id} --- ${reponse.description} --- ${reponse.syllabus}");
      expect(reponse.description, course.description);
      expect(reponse.syllabus, course.syllabus);
    });

    test("deve atualizar informações do curso", () async {
      reponse = await repository.update(CourseModel(
          id: idComparison,
          description: "Curso Docker 2.0",
          syllabus: "Atualizão do curso"));

      //Confimação do registro
      final reponseComparison = await repository.getById(reponse.id);
      print(
          "Action [Update] --- ${reponse.id} --- ${reponse.description} --- ${reponse.syllabus}");
      expect(reponseComparison.id, idComparison);
      expect(reponse.description, reponseComparison.description);
      expect(reponse.syllabus, reponseComparison.syllabus);
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

var course = CourseModel(
    id: 0,
    description: "Curso Docker",
    syllabus: "Curso docke para criar de container");
