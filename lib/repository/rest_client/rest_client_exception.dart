import 'dart:convert';
import 'package:gerenciamento_escolar/repository/rest_client/model/rest_error.dart';
import 'irest_response.dart';

class RestClientException implements Exception {
  final IRestResponse response;
  final String message;
  RestClientException(this.message, this.response);

  @override
  String toString() {
    RestError getMsg = RestError.fromJson(jsonDecode(response.content));
    return "${getMsg.error}\n${getMsg.message}\n";
  }

  String getMessage() {
    return RestError.fromJson(jsonDecode(response.content)).message;
  }
}
