import 'dart:convert';

import 'package:escola/model/student_model.dart';
import 'package:escola/repository/rest_client/irest_client.dart';
import 'package:escola/repository/student_repository/i_student_repository.dart';
import 'package:escola/utils/request_settings.dart';

class StudentRepository implements IStudentRepository {
  final String domain;
  final IRestClient _restClient;

  StudentRepository(
    this._restClient,
    this.domain,
  );

  final String _api = "/student";

  @override
  Future<List<StudentModel>> getAll() async {
    final response = await _restClient.sendGet(
      url: domain + _api,
    );

    response.ensureSuccess(
        restClientExceptionMessage: "Erro ao reculperar lista de aluno");

    List<dynamic> list = jsonDecode(response.content);
    return list.map((e) => StudentModel.fromJson(e)).toList();
  }

  @override
  Future<StudentModel> getById(int idStudent) async {
    final response = await _restClient.sendGet(url: "$domain$_api/$idStudent");
    response.ensureSuccess(
        restClientExceptionMessage: "Erro ao consultar aluno");

    return StudentModel.fromJson(jsonDecode(response.content));
  }

  @override
  Future<StudentModel> register(StudentModel student) async {
    final response = await _restClient.sendPost(
        url: domain + _api,
        headers: RequestSettings.headerTypeJson,
        body: student.toJson());

    response.ensureSuccess(
        statusCodeSucces: 201,
        restClientExceptionMessage: "Erro ao registrar aluno");

    return StudentModel.fromJson(jsonDecode(response.content));
  }

  @override
  Future<StudentModel> update(StudentModel student) async {
    final response = await _restClient.sendPut(
        url: domain + _api,
        headers: RequestSettings.headerTypeJson,
        body: student.toJson());

    response.ensureSuccess(
        restClientExceptionMessage: "Erro ao registrar atualizar aluno");

    return StudentModel.fromJson(jsonDecode(response.content));
  }

  @override
  Future<void> delete(int idStudent) async {
    final response = await _restClient.sendDelete(
      url: "$domain$_api/$idStudent",
    );
    response.ensureSuccess(
        statusCodeSucces: 204,
        restClientExceptionMessage:
            "Erro ao excluir aluno. Caso exista cursos matriculados não sera possivel excluir aluno!");
  }
}
