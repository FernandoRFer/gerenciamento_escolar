import 'package:gerenciamento_escolar/components/app_search.dart';
import 'package:gerenciamento_escolar/components/error_view.dart';
import 'package:gerenciamento_escolar/components/list_students.dart';
import 'package:gerenciamento_escolar/components/loading.dart';
import 'package:flutter/material.dart';
import 'students_bloc.dart';

class StudentView extends StatefulWidget {
  final IStudentBloc bloc;
  const StudentView(
    this.bloc, {
    super.key,
  });

  @override
  State<StudentView> createState() => _StudentViewState();
}

class _StudentViewState extends State<StudentView> {
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
    return StreamBuilder<StudentStates>(
        stream: widget.bloc.onFetchingData,
        initialData: StudentModelBloc(),
        builder: (context, snapshot) {
          if (!snapshot.hasError) {
            if (snapshot.hasData) {
              if (snapshot.data is LoadingStudentStates) {
                return Scaffold(
                  body: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: AnimatedLoading(
                          title:
                              (snapshot.data! as LoadingStudentStates).title),
                    ),
                  ),
                );
              }
            }
            if (snapshot.data is StudentModelBloc) {
              final studentModelBloc = (snapshot.data as StudentModelBloc);
              return Scaffold(
                appBar: AppBar(
                  title: const Text("Alunos"),
                ),
                floatingActionButton: FloatingActionButton.extended(
                    label: const Text("Novo cadastro"),
                    onPressed: () {
                      widget.bloc.navegateStudentCreate();
                    }),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        AppSearch(context,
                            itens: ListStudents(
                              students: studentModelBloc.students,
                              onTapItem: widget.bloc.studentDetails,
                            ),
                            title: 'pesquisa',
                            search: studentModelBloc.search,
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

          return const Center(child: Text("Sem dados para exibir"));
        });
  }
}
