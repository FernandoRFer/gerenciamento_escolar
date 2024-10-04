import 'package:gerenciamento_escolar/model/student_model.dart';
import 'package:flutter/material.dart';

class ListEnrollmentStudent extends StatelessWidget {
  final List<StudentModel> students;
  final void Function(StudentModel)? onTapItem;
  const ListEnrollmentStudent({
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
          title: Text(students[index].name),
        );
      },
    );
  }
}
