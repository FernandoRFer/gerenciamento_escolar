import 'package:gerenciamento_escolar/model/course_model.dart';
import 'package:gerenciamento_escolar/repository/couse_repository/i_course_repository.dart';
import 'package:gerenciamento_escolar/core/utils/mocks/mock_data.dart';

class MockCourse implements ICourseRepository {
  @override
  Future<void> delete(int idCourse) async {
    listCourseModel.removeWhere((e) => e.id == idCourse);
  }

  @override
  Future<List<CourseModel>> getAll() async {
    return listCourseModel;
  }

  @override
  Future<CourseModel> register(CourseModel course) async {
    listCourseModel.add(course);
    return course;
  }

  @override
  Future<CourseModel> update(CourseModel courseUpdate) async {
    for (int i = 0; i < listCourseModel.length; i++) {
      if (listCourseModel[i].id == courseUpdate.id) {
        listCourseModel[i] = courseUpdate;
        return listCourseModel[i];
      }
    }

    throw ("Curso não localizado");
  }

  @override
  Future<CourseModel> getById(int idCourse) async {
    for (var course in listCourseModel) {
      if (course.id == idCourse) {
        return course;
      }
    }
    throw ("Curso não localizado");
  }
}
