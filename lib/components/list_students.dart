// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:escola/model/student_model.dart';

class ListStudents extends StatelessWidget {
  final List<StudentModel> students;
  final void Function()? onTapItem;
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
          onTap: onTapItem,
          leading: const CircleAvatar(
            child: Icon(Icons.person_outline),
          ),
          title: Text(students[index].nome),
        );
      },
    );
  }
}
