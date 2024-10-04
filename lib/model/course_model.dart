class CourseModel {
  int id;
  String description;
  String syllabus;

  CourseModel({
    required this.id,
    required this.description,
    required this.syllabus,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
      'syllabus': syllabus,
    };
  }

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json['id'] ?? 0,
      description: json['description'] ?? "",
      syllabus: json['syllabus'] ?? "",
    );
  }
}
