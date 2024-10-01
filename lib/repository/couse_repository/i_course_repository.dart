import 'package:escola/model/course_model.dart';

abstract class ICourseRepository {
  Future<List<CourseModel>> getAll();
  Future<void> register(CourseModel course);
  Future<void> update(CourseModel course);
  Future<void> delete(CourseModel course);
}
