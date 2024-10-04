import 'package:gerenciamento_escolar/components/app_search.dart';
import 'package:gerenciamento_escolar/components/error_view.dart';
import 'package:gerenciamento_escolar/components/list_courses.dart';
import 'package:gerenciamento_escolar/components/loading.dart';
import 'package:flutter/material.dart';
import 'course_bloc.dart';

class CourseView extends StatefulWidget {
  final ICourseBloc bloc;
  const CourseView(
    this.bloc, {
    super.key,
  });

  @override
  State<CourseView> createState() => _CourseViewState();
}

class _CourseViewState extends State<CourseView> {
  @override
  void initState() {
    super.initState();
    widget.bloc.load();
  }

  @override
  void dispose() {
    super.dispose();
    widget.bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<CourseStates>(
        stream: widget.bloc.onFetchingData,
        initialData: CourseModelBloc(),
        builder: (context, snapshot) {
          if (!snapshot.hasError) {
            if (snapshot.hasData) {
              if (snapshot.data is LoadingCourseStates) {
                return Scaffold(
                  body: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: AnimatedLoading(
                          title: (snapshot.data! as LoadingCourseStates).title),
                    ),
                  ),
                );
              }
            }
            if (snapshot.data is CourseModelBloc) {
              final listCourses = (snapshot.data as CourseModelBloc);
              return Scaffold(
                appBar: AppBar(
                  title: const Text("Cursos"),
                ),
                floatingActionButton: FloatingActionButton.extended(
                    label: const Text("Adicionar Curso"),
                    onPressed: () {
                      widget.bloc.navegateCourseCreate();
                    }),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        AppSearch(context,
                            itens: ListCourse(
                              courses: listCourses.courses,
                              onTapItem: widget.bloc.studentDetails,
                            ),
                            title: 'pesquisa',
                            search: listCourses.search,
                            secondaryActionIcon: widget.bloc.claenSearch,
                            onChangedSearch: widget.bloc.search),
                      ],
                    ),
                  ),
                ),
              );
            }
          } else {
            return Scaffold(
              body: ErrorView(
                  title: "Error",
                  subtitle: snapshot.error.toString(),
                  buttons: [
                    OutlinedButton(
                      child: const Center(child: Text("Back")),
                      onPressed: () {
                        widget.bloc.load();
                        widget.bloc.navigatorPop();
                      },
                    ),
                  ]),
            );
          }

          return const Scaffold(
            body: Center(
              child: Text("Sem cursos para exibir"),
            ),
          );
        });
  }
}
