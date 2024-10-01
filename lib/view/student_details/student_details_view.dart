import 'dart:developer';

import 'package:escola/components/app_dialog.dart';
import 'package:escola/components/bottom_sheet.dart';
import 'package:escola/components/error_view.dart';
import 'package:escola/components/list_enrolled_courses.dart';
import 'package:escola/components/loading.dart';
import 'package:escola/model/student_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'student_details_bloc.dart';

class StudentDetailsViewArguments {
  StudentModel studentSelect;
  StudentDetailsViewArguments({required this.studentSelect});
}

class StudentDetailsView extends StatefulWidget {
  final IStudentDetailsBloc bloc;
  const StudentDetailsView(
    this.bloc, {
    super.key,
  });

  @override
  State<StudentDetailsView> createState() => _StudentDetailsViewState();
}

class _StudentDetailsViewState extends State<StudentDetailsView> {
  final List<GlobalKey> keys = [];
  int errorteste = 0;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      final args = ModalRoute.of(context)!.settings.arguments
          as StudentDetailsViewArguments?;

      widget.bloc.retrievingArgument(args?.studentSelect);
    });
  }

  @override
  void dispose() {
    super.dispose();
    widget.bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return StreamBuilder<StudentDetailsStates>(
        stream: widget.bloc.onFetchingData,
        initialData: LoadingStudentDetailsStates(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return ErrorView(
                title: "Error",
                subtitle: snapshot.error.toString(),
                buttons: [
                  OutlinedButton(
                    child: const Center(child: Text("Voltar")),
                    onPressed: () {
                      widget.bloc.navigatorPop();
                      widget.bloc.navigatorPop();
                    },
                  ),
                ]);
          } else {
            if (snapshot.hasData) {
              if (snapshot.data is LoadingStudentDetailsStates) {
                return Scaffold(
                  appBar: AppBar(
                    title: const Text("Aluno"),
                  ),
                  body: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: AnimatedLoading(
                          title: (snapshot.data! as LoadingStudentDetailsStates)
                              .title),
                    ),
                  ),
                );
              }
            }
            if (snapshot.data is StudentDetailsModelBloc) {
              final studentDetails = snapshot.data as StudentDetailsModelBloc;

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
                                          onPressed: widget.bloc.navigatorPop,
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
                                          initialValue:
                                              studentDetails.student.nome,
                                          onChanged: (value) => studentDetails
                                              .student.nome = value,
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
                                        widget.bloc.navigatorPop();
                                        widget.bloc
                                            .update(studentDetails.student);
                                      },
                                      child: const Center(
                                          child: Text("Atualizar")),
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
                                    onPressed: widget.bloc.navigatorPop);
                              } else {
                                AppDialog.showMyDialogOptions(
                                    context: context,
                                    title:
                                        "O aluno \"${studentDetails.student.nome}\" será excluido",
                                    subtitle: "Deseja continuar?",
                                    actionTrue: () {
                                      widget.bloc.deleteStuderd();
                                      widget.bloc.navigatorPop();
                                    },
                                    actionFalse: () {
                                      widget.bloc.navigatorPop();
                                    });
                              }
                            },
                            icon: const Icon(Icons.delete)),
                      ],
                    ),
                  ],
                ),
                body: Center(
                  child: LayoutBuilder(builder: (context, boxConstraints) {
                    return SingleChildScrollView(
                      child: SizedBox(
                        height: boxConstraints.maxHeight,
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
                                  studentDetails.student.nome.toUpperCase(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: theme
                                          .textTheme.titleMedium?.fontSize),
                                ),
                              ),
                              Center(
                                child: Text(
                                  "Código: ${studentDetails.student.codigo.toString()}",
                                  style: TextStyle(
                                      fontSize: theme
                                          .textTheme.titleMedium?.fontSize),
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
                                                fontSize: theme.textTheme
                                                    .titleMedium?.fontSize),
                                          ),
                                        ),
                                        Card(
                                            color: theme.colorScheme
                                                .surfaceContainerHighest,
                                            margin: const EdgeInsets.all(0),
                                            child: ListEnrolledCourse(
                                              courses: studentDetails.courses,
                                              onTapItem: (itemSelect) {
                                                AppDialog.showMyDialogOptions(
                                                    context: context,
                                                    title:
                                                        "A matricula do curso \"${itemSelect.course.descricao}\" será cancelada",
                                                    subtitle:
                                                        "Deseja continuar?",
                                                    actionTrue: () {
                                                      widget.bloc
                                                          .deleteEnrollment(
                                                              itemSelect
                                                                  .idEnrolled);
                                                      widget.bloc
                                                          .navigatorPop();
                                                    },
                                                    actionFalse: () {
                                                      widget.bloc
                                                          .navigatorPop();
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
                              const Expanded(child: SizedBox()),
                              FilledButton(
                                  child: Center(
                                    child: Text("Matricular em Novo Curso",
                                        style: TextStyle(
                                          fontSize: theme
                                              .textTheme.titleMedium?.fontSize,
                                        )),
                                  ),
                                  onPressed: () {}),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              );
            }
          }

          return const Center(
            child: Text("Sem cursos para exibir"),
          );
        });
  }
}
