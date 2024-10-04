import 'package:gerenciamento_escolar/model/course_model.dart';
import 'package:flutter/material.dart';

class ListEnrollmentCourse extends StatelessWidget {
  final List<CourseModel> courses;
  final void Function(CourseModel)? onTapItem;
  const ListEnrollmentCourse({
    super.key,
    required this.courses,
    this.onTapItem,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: courses.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: const CircleAvatar(
            child: Icon(Icons.library_books),
          ),
          trailing: IconButton(
              onPressed: () {
                onTapItem!(courses[index]);
              },
              icon: const Icon(Icons.delete_outline_rounded)),
          title: Text(courses[index].description),
        );
      },
    );
  }
}
