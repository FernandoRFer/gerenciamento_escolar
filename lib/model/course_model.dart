class CourseModel {
  int codigo;
  String descricao;
  String ementa;

  CourseModel({
    required this.codigo,
    required this.descricao,
    required this.ementa,
  });

  Map<String, dynamic> toJson() {
    return {
      'codigo': codigo,
      'descricao': descricao,
      'ementa': ementa,
    };
  }

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      codigo: json['codigo'] ?? 0,
      descricao: json['descricao'] ?? "",
      ementa: json['ementa'] ?? "",
    );
  }
}
