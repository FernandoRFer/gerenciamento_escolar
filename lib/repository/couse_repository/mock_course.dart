import 'package:escola/model/course_model.dart';
import 'package:escola/repository/couse_repository/i_course_repository.dart';

class MockCourse implements ICourseRepository {
  @override
  Future<void> delete(CourseModel courseDelete) async {
    listCourseModel.removeWhere((e) => e.codigo == courseDelete.codigo);
  }

  @override
  Future<List<CourseModel>> getAll() async {
    return listCourseModel;
  }

  @override
  Future<void> register(CourseModel course) async {
    listCourseModel.add(course);
  }

  @override
  Future<void> update(CourseModel courseUpdate) async {
    for (var course in listCourseModel) {
      if (course.codigo == courseUpdate.codigo) {
        course = courseUpdate;
      }
    }
  }
}

final List<CourseModel> listCourseModel = [
  CourseModel(
      codigo: 1,
      descricao: "Introdução à Programação",
      ementa:
          "Este curso aborda os conceitos básicos de programação, incluindo estruturas de controle, variáveis e funções."),
  CourseModel(
      codigo: 2,
      descricao: "ADM",
      ementa:
          "Este curso aborda os conceitos básicos de programação, incluindo estruturas de controle, variáveis e funções."),
  CourseModel(
      codigo: 3,
      descricao: "direito",
      ementa:
          "Este curso aborda os conceitos básicos de programação, incluindo estruturas de controle, variáveis e funções."),
  CourseModel(
      codigo: 4,
      descricao: "Fisoterapia",
      ementa:
          "Este curso aborda os conceitos básicos de programação, incluindo estruturas de controle, variáveis e funções."),
];
