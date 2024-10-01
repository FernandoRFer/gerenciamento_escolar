import 'package:escola/model/enrolled_couse.dart';
import 'package:flutter/material.dart';

class ListEnrolledCourse extends StatelessWidget {
  final List<EnrolledCourse> courses;
  final void Function(EnrolledCourse)? onTapItem;
  const ListEnrolledCourse({
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
          // onTap: () {
          //   onTapItem!(courses[index]);
          // },
          leading: const CircleAvatar(
            child: Icon(Icons.library_books),
          ),
          trailing: IconButton(
              onPressed: () {
                onTapItem!(courses[index]);
              },
              icon: const Icon(Icons.delete_outline_rounded)),
          title: Text(courses[index].course.descricao),
        );
      },
    );
  }
}
