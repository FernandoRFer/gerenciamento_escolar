import 'package:escola/model/enrolled_student.dart';
import 'package:flutter/material.dart';

class ListEnrolledStudent extends StatelessWidget {
  final List<EnrolledStudent> students;
  final void Function(EnrolledStudent)? onTapItem;
  const ListEnrolledStudent({
    super.key,
    required this.students,
    this.onTapItem,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: students.length,
      itemBuilder: (context, index) {
        return ListTile(
          // onTap: () {
          //   onTapItem!(students[index]);
          // },
          leading: const CircleAvatar(
            child: Icon(Icons.person_outline),
          ),
          trailing: IconButton(
              onPressed: () {
                onTapItem!(students[index]);
              },
              icon: const Icon(Icons.delete_outline_rounded)),
          title: Text(students[index].student.nome),
        );
      },
    );
  }
}
