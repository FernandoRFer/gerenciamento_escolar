import 'package:escola/components/app_dialog.dart';
import 'package:escola/components/list_enrolled_stadents.dart';
import 'package:escola/view/course_details/course_details_bloc.dart';
import 'package:flutter/material.dart';

class CourseDetalisWidget extends StatefulWidget {
  final CourseDetailsModelBloc courseDetails;
  final ICourseDetailsBloc bloc;

  const CourseDetalisWidget({
    super.key,
    required this.courseDetails,
    required this.bloc,
  });

  @override
  State<CourseDetalisWidget> createState() => _CourseDetalisWidgetState();
}

class _CourseDetalisWidgetState extends State<CourseDetalisWidget> {
  AppBar _appBar() {
    return AppBar(
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
                                  widget.courseDetails.course.description,
                              onChanged: (value) => widget
                                  .courseDetails.course.description = value,
                              decoration: const InputDecoration(
                                labelText: "Descrição",
                              ),
                            ),
                            const SizedBox(height: 12),
                            TextFormField(
                              maxLines: 2,
                              initialValue:
                                  widget.courseDetails.course.syllabus,
                              onChanged: (value) =>
                                  widget.courseDetails.course.syllabus = value,
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
                            widget.bloc.update(widget.courseDetails.course);
                          },
                          child: const Center(child: Text("Atualizar")),
                        )
                      ]);
                },
                icon: const Icon(Icons.edit_outlined)),
            IconButton(
                onPressed: () {
                  if (widget.courseDetails.studants.isNotEmpty) {
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
                            "O aluno \"${widget.courseDetails.course.description}\" será excluido",
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
    );
  }

  Widget _listStudents(ThemeData theme) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Alunos matriculados:",
            style: TextStyle(fontSize: theme.textTheme.titleMedium?.fontSize),
          ),
        ),
        Card(
            margin: const EdgeInsets.all(0),
            child: ListEnrollmentStudent(
              students: widget.courseDetails.studants,
              onTapItem: (itemSelect) {
                AppDialog.showMyDialogOptions(
                    context: context,
                    title:
                        "A matricula do aluno \"${itemSelect.name}\" para esse curso será cancelada",
                    subtitle: "Deseja continuar?",
                    actionTrue: () async {
                      widget.bloc.navigatorPop();
                      await widget.bloc.deleteEnrollment(itemSelect.id);
                    },
                    actionFalse: () {
                      widget.bloc.navigatorPop();
                    });
              },
            )),
      ],
    );
  }

  Widget _headerCourse(ThemeData theme) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            widget.courseDetails.course.description.toUpperCase(),
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: theme.textTheme.titleLarge?.fontSize),
          ),
        ),
        const SizedBox(height: 8),
        Card(
          color: theme.colorScheme.secondaryContainer,
          margin: const EdgeInsets.all(0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                widget.courseDetails.course.syllabus,
                textAlign: TextAlign.justify,
                style:
                    TextStyle(fontSize: theme.textTheme.titleMedium?.fontSize),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: _appBar(),
      body: LayoutBuilder(builder: (context, boxConstraints) {
        return SingleChildScrollView(
          child: SizedBox(
            height: boxConstraints.maxHeight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  _headerCourse(theme),
                  const SizedBox(height: 8),
                  widget.courseDetails.studants.isNotEmpty
                      ? _listStudents(theme)
                      : const Center(
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text(
                              "Não há aluno matriculados.",
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
