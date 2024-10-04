import 'package:escola/view/student_details/components/list_courses_enrolled.dart';
import 'package:escola/view/student_details/student_details_bloc.dart';
import 'package:flutter/material.dart';

import 'package:escola/components/app_dialog.dart';

class StudentDetailsWidget extends StatelessWidget {
  final StudentDetailsModelBloc studentDetails;
  final IStudentDetailsBloc bloc;
  const StudentDetailsWidget({
    super.key,
    required this.studentDetails,
    required this.bloc,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Aluno"),
        actions: [
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    AppDialog.showMDialog(
                        context: context,
                        title: Row(
                          children: [
                            const Expanded(
                                child: Text("Editar aluno",
                                    overflow: TextOverflow.clip)),
                            IconButton(
                                onPressed: bloc.navigatorPop,
                                icon: const Icon(Icons.close))
                          ],
                        ),
                        content: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(height: 8),
                              TextFormField(
                                maxLines: 2,
                                initialValue: studentDetails.student.name,
                                onChanged: (value) =>
                                    studentDetails.student.name = value,
                                decoration: const InputDecoration(
                                  labelText: "Nome",
                                ),
                              ),
                            ],
                          ),
                        ),
                        actions: [
                          FilledButton(
                            onPressed: () {
                              bloc.navigatorPop();
                              bloc.update(studentDetails.student);
                            },
                            child: const Center(child: Text("Atualizar")),
                          )
                        ]);
                  },
                  icon: const Icon(Icons.edit_outlined)),
              IconButton(
                  onPressed: () {
                    if (studentDetails.courses.isNotEmpty) {
                      AppDialog.showDialogInf(
                          context: context,
                          title: "Atenção",
                          subtitle:
                              "Não é possivel excluir alunos que estão macriculados em algum curso!",
                          onPressed: bloc.navigatorPop);
                    } else {
                      AppDialog.showMyDialogOptions(
                          context: context,
                          title:
                              "O aluno \"${studentDetails.student.name}\" será excluido",
                          subtitle: "Deseja continuar?",
                          actionTrue: () {
                            bloc.navigatorPop();
                            bloc.deleteStuderd();
                          },
                          actionFalse: () {
                            bloc.navigatorPop();
                          });
                    }
                  },
                  icon: const Icon(Icons.delete)),
            ],
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
          label: Text("Matricular em Novo Curso",
              style: TextStyle(
                fontSize: theme.textTheme.titleMedium?.fontSize,
              )),
          onPressed: () {}),
      body: SingleChildScrollView(
          child: SizedBox(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 50,
                child: Icon(Icons.person_outline, size: 40),
              ),
              const SizedBox(height: 8),
              Center(
                child: Text(
                  studentDetails.student.name.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: theme.textTheme.titleMedium?.fontSize),
                ),
              ),
              Center(
                child: Text(
                  "Código: ${studentDetails.student.id.toString()}",
                  style: TextStyle(
                      fontSize: theme.textTheme.titleMedium?.fontSize),
                ),
              ),
              const SizedBox(height: 8),
              studentDetails.courses.isNotEmpty
                  ? Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Cursos matriculados:",
                            style: TextStyle(
                                fontSize:
                                    theme.textTheme.titleMedium?.fontSize),
                          ),
                        ),
                        Card(
                            color: theme.colorScheme.surfaceContainerHighest,
                            margin: const EdgeInsets.all(0),
                            child: ListEnrollmentCourse(
                              courses: studentDetails.courses,
                              onTapItem: (itemSelect) {
                                AppDialog.showMyDialogOptions(
                                    context: context,
                                    title:
                                        "A matricula do curso \"${itemSelect.description}\" será cancelada",
                                    subtitle: "Deseja continuar?",
                                    actionTrue: () {
                                      bloc.deleteEnrollment(itemSelect);
                                      bloc.navigatorPop();
                                    },
                                    actionFalse: () {
                                      bloc.navigatorPop();
                                    });
                              },
                            )),
                      ],
                    )
                  : const Center(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          "Não há cursos matriculados.",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
            ],
          ),
        ),
      )),
    );
  }
}
