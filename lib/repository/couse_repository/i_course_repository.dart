import 'package:escola/model/course_model.dart';

abstract class ICourseRepository {
  Future<List<CourseModel>> getAll();
  Future<CourseModel> getById(int idCourse);
  Future<CourseModel> register(CourseModel course);
  Future<CourseModel> update(CourseModel course);
  Future<void> delete(int idCourse);
}
