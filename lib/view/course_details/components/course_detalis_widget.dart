import 'package:gerenciamento_escolar/components/app_card.dart';
import 'package:gerenciamento_escolar/components/app_dialog.dart';
import 'package:gerenciamento_escolar/components/list_enrolled_stadents.dart';
import 'package:gerenciamento_escolar/view/course_details/course_details_bloc.dart';
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
                  widget.bloc.update();
                },
                icon: const Icon(Icons.edit_outlined)),
            IconButton(
                onPressed: () {
                  if (widget.courseDetails.students.isNotEmpty) {
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
              students: widget.courseDetails.students,
              onTapItem: (itemSelect) {
                AppDialog.showMyDialogOptions(
                    context: context,
                    title:
                        "A matricula do aluno \"${itemSelect.name}\" para esse curso será cancelada",
                    subtitle: "Deseja continuar?",
                    actionTrue: () async {
                      widget.bloc.navigatorPop();
                      await widget.bloc.deleteEnrollment(itemSelect);
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              widget.courseDetails.course.description.toUpperCase(),
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: theme.textTheme.titleLarge?.fontSize),
            ),
          ),
        ),
        const SizedBox(height: 8),
        CCard(
          color: theme.colorScheme.secondaryContainer,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              widget.courseDetails.course.syllabus,
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: theme.textTheme.titleMedium?.fontSize),
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
      body: SingleChildScrollView(
        child: SizedBox(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(height: 8),
                _headerCourse(theme),
                const SizedBox(height: 8),
                widget.courseDetails.students.isNotEmpty
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
      ),
    );
  }
}
