import 'dart:convert';

import 'package:escola/model/course_model.dart';
import 'package:escola/model/enrollment_model.dart';
import 'package:escola/model/student_model.dart';
import 'package:escola/repository/enrollment_repository/i_enrollment_repository.dart';
import 'package:escola/repository/rest_client/irest_client.dart';
import 'package:escola/utils/request_settings.dart';

class EnrollmentRepository implements IEnrollmentRepository {
  final IRestClient _restClient;
  final String domain;
  EnrollmentRepository(
    this._restClient,
    this.domain,
  );

  final String _api = "/enrollment";

  @override
  Future<void> deleteEnrollment(int idStudent, int idCourse) async {
    final response = await _restClient.sendDelete(
      url: "$domain$_api?idstudent=$idStudent&idcourse=$idCourse",
    );
    response.ensureSuccess(
        statusCodeSucces: 204,
        restClientExceptionMessage:
            "Erro ao excluir cursos. Caso exista alunos matriculados não sera possivel excluir curso!");
  }

  @override
  Future<void> register(EnrollmentModel enrollment) async {
    final response = await _restClient.sendPost(
        url: domain + _api,
        headers: RequestSettings.headerTypeJson,
        body: enrollment.toJson());

    response.ensureSuccess(
        statusCodeSucces: 201,
        restClientExceptionMessage: "Erro ao registrar curso");
  }

  @override
  Future<List<StudentModel>> getDetailsCourse(int idCourse) async {
    final response = await _restClient.sendGet(
      url: "$domain$_api/students-enrollment/$idCourse",
    );
    response.ensureSuccess(
        restClientExceptionMessage:
            "Erro ao carregar lista de estudates matriculados");
    List<dynamic> list = jsonDecode(response.content);
    return list.map((e) => StudentModel.fromJson(e)).toList();
  }

  @override
  Future<List<CourseModel>> getDetailsStudent(int idStudent) async {
    final response = await _restClient.sendGet(
      url: "$domain$_api/courses-enrollment/$idStudent",
    );
    response.ensureSuccess(
        restClientExceptionMessage:
            "Erro ao carregar lista de estudates matriculados");
    List<dynamic> list = jsonDecode(response.content);
    return list.map((e) => CourseModel.fromJson(e)).toList();
  }
}
