class RestError {
  String timestamp;
  int status;
  String error;
  String message;
  String path;

  RestError(
      {this.timestamp = "",
      this.status = 0,
      this.error = "Não idendificado",
      this.message = "",
      this.path = ""});

  RestError.fromJson(Map<String, dynamic> json)
      : timestamp = json['timestamp'],
        status = json['status'],
        error = json['error'],
        message = json['message'],
        path = json['path'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['timestamp'] = timestamp;
    data['status'] = status;
    data['error'] = error;
    data['message'] = message;
    data['path'] = path;
    return data;
  }
}
