import 'package:flutter/material.dart';

import 'package:gerenciamento_escolar/model/student_model.dart';

class ListStudents extends StatelessWidget {
  final List<StudentModel> students;
  final void Function(StudentModel)? onTapItem;
  const ListStudents({
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
          // onLongPress: () =>
          //     onLongPress(isSelected, index),
          onTap: () {
            onTapItem!(students[index]);
          },
          leading: const CircleAvatar(
            child: Icon(Icons.person_outline),
          ),
          title: Text(students[index].name),
        );
      },
    );
  }
}
