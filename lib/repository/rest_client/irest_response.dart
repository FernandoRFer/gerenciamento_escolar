import 'dart:typed_data';

abstract class IRestResponse {
  int get statusCode;
  String get url;
  String get content;
  Uint8List get contentBytes;
  void ensureSuccess(
      {int statusCodeSucces = 200,
      Function()? customErrorMessage,
      required String restClientExceptionMessage});
}
