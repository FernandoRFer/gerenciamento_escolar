// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:gerenciamento_escolar/model/course_model.dart';
import 'package:gerenciamento_escolar/repository/couse_repository/i_course_repository.dart';
import 'package:gerenciamento_escolar/repository/rest_client/irest_client.dart';
import 'package:gerenciamento_escolar/core/utils/request_settings.dart';

class CourseRepository implements ICourseRepository {
  final IRestClient _restClient;
  final String domain;
  CourseRepository(
    this._restClient,
    this.domain,
  );

  final String _api = "/course";

  @override
  Future<List<CourseModel>> getAll() async {
    final response = await _restClient.sendGet(
      url: domain + _api,
    );
    response.ensureSuccess(
        restClientExceptionMessage: "Erro ao reculperar lista de cursos");

    List<dynamic> list = jsonDecode(response.content);
    return list.map((e) => CourseModel.fromJson(e)).toList();
  }

  @override
  Future<CourseModel> getById(int idCourse) async {
    final response = await _restClient.sendGet(url: "$domain$_api/$idCourse");
    response.ensureSuccess(
        restClientExceptionMessage: "Erro ao consultar curso");

    return CourseModel.fromJson(jsonDecode(response.content));
  }

  @override
  Future<void> delete(int course) async {
    final response = await _restClient.sendDelete(
      url: "$domain$_api/$course",
    );
    response.ensureSuccess(
        statusCodeSucces: 204,
        restClientExceptionMessage:
            "Erro ao excluir cursos. Caso exista alunos matriculados não sera possivel excluir curso!");
  }

  @override
  Future<CourseModel> register(CourseModel course) async {
    final response = await _restClient.sendPost(
        url: domain + _api,
        headers: RequestSettings.headerTypeJson,
        body: course.toJson());

    response.ensureSuccess(
        restClientExceptionMessage: "Erro ao registrar curso");

    return CourseModel.fromJson(jsonDecode(response.content));
  }

  @override
  Future<CourseModel> update(CourseModel course) async {
    final response = await _restClient.sendPut(
        url: domain + _api,
        headers: RequestSettings.headerTypeJson,
        body: course.toJson());

    response.ensureSuccess(
        restClientExceptionMessage: "Erro ao atualizar curso");

    return CourseModel.fromJson(jsonDecode(response.content));
  }
}
