class StudentModel {
  int codigo;
  String nome;
  StudentModel({
    required this.codigo,
    required this.nome,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'codigo': codigo,
      'nome': nome,
    };
  }

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      codigo: json['codigo'] ?? 0,
      nome: json['nome'] ?? "",
    );
  }
}
