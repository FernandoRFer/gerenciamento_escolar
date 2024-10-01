import 'dart:developer';

import 'package:escola/components/app_dialog.dart';
import 'package:escola/components/bottom_sheet.dart';
import 'package:escola/components/error_view.dart';
import 'package:escola/components/list_enrolled_courses.dart';
import 'package:escola/components/list_enrolled_stadents.dart';
import 'package:escola/components/loading.dart';
import 'package:escola/model/course_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'course_details_bloc.dart';

class CourseDetailsViewArguments {
  CourseModel courseSelect;
  CourseDetailsViewArguments({required this.courseSelect});
}

class CourseDetailsView extends StatefulWidget {
  final ICourseDetailsBloc bloc;
  const CourseDetailsView(
    this.bloc, {
    super.key,
  });

  @override
  State<CourseDetailsView> createState() => _CourseDetailsViewState();
}

class _CourseDetailsViewState extends State<CourseDetailsView> {
  final List<GlobalKey> keys = [];
  int errorteste = 0;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      final args = ModalRoute.of(context)!.settings.arguments
          as CourseDetailsViewArguments?;

      widget.bloc.retrievingArgument(args?.courseSelect);
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
    return StreamBuilder<CourseDetailsStates>(
        stream: widget.bloc.onFetchingData,
        initialData: LoadingCourseDetailsStates(),
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
              if (snapshot.data is LoadingCourseDetailsStates) {
                return Scaffold(
                  appBar: AppBar(
                    title: const Text("Curso"),
                  ),
                  body: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: AnimatedLoading(
                          title: (snapshot.data! as LoadingCourseDetailsStates)
                              .title),
                    ),
                  ),
                );
              }
            }
            if (snapshot.data is CourseDetailsModelBloc) {
              final courseDetails = snapshot.data as CourseDetailsModelBloc;

              return Scaffold(
                appBar: AppBar(
                  title: const Text("Curso"),
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
                                            overflow: TextOverflow.clip),
                                      ),
                                      IconButton(
                                          onPressed: widget.bloc.navigatorPop,
                                          icon: const Icon(Icons.close))
                                    ],
                                  ),
                                  content: SingleChildScrollView(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        TextFormField(
                                          maxLines: 1,
                                          initialValue:
                                              courseDetails.course.descricao,
                                          onChanged: (value) => courseDetails
                                              .course.descricao = value,
                                          decoration: const InputDecoration(
                                            labelText: "Descrição",
                                          ),
                                        ),
                                        const SizedBox(height: 12),
                                        TextFormField(
                                          maxLines: 2,
                                          initialValue:
                                              courseDetails.course.ementa,
                                          onChanged: (value) => courseDetails
                                              .course.descricao = value,
                                          decoration: const InputDecoration(
                                            labelText: "Ementa",
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
                                            .update(courseDetails.course);
                                      },
                                      child: const Center(
                                          child: Text("Atualizar")),
                                    )
                                  ]);
                            },
                            icon: const Icon(Icons.edit_outlined)),
                        IconButton(
                            onPressed: () {
                              if (courseDetails.studants.isNotEmpty) {
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
                                        "O aluno \"${courseDetails.course.descricao}\" será excluido",
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
                              const SizedBox(height: 8),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  courseDetails.course.descricao.toUpperCase(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                          theme.textTheme.titleLarge?.fontSize),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Center(
                                child: Text(
                                  courseDetails.course.ementa,
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                      fontSize: theme
                                          .textTheme.titleMedium?.fontSize),
                                ),
                              ),
                              const Divider(),
                              courseDetails.studants.isNotEmpty
                                  ? Column(
                                      children: [
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "Alunos matriculados:",
                                            style: TextStyle(
                                                fontSize: theme.textTheme
                                                    .titleMedium?.fontSize),
                                          ),
                                        ),
                                        Card(
                                            color: theme.colorScheme
                                                .surfaceContainerHighest,
                                            margin: const EdgeInsets.all(0),
                                            child: ListEnrolledStudent(
                                              students: courseDetails.studants,
                                              onTapItem: (itemSelect) {
                                                AppDialog.showMyDialogOptions(
                                                    context: context,
                                                    title:
                                                        "A matricula do aluno \"${itemSelect.student.nome}\" para esse curso será cancelada",
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
                                          "Não há aluno matriculados.",
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
