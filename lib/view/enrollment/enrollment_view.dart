import 'package:gerenciamento_escolar/components/app_search.dart';
import 'package:gerenciamento_escolar/components/error_view.dart';
import 'package:gerenciamento_escolar/components/list_students.dart';
import 'package:gerenciamento_escolar/components/loading.dart';
import 'package:gerenciamento_escolar/components/success.dart';
import 'package:gerenciamento_escolar/core/utils/validator.dart';
import 'package:gerenciamento_escolar/model/course_model.dart';
import 'package:gerenciamento_escolar/model/student_model.dart';
import 'package:flutter/material.dart';
import 'enrollment_bloc.dart';

class EnrollmentView extends StatefulWidget {
  final IEnrollmentBloc bloc;
  const EnrollmentView(
    this.bloc, {
    super.key,
  });

  @override
  State<EnrollmentView> createState() => _EnrollmentViewState();
}

class _EnrollmentViewState extends State<EnrollmentView> with Validator {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    widget.bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return StreamBuilder<EnrollmentStates>(
        stream: widget.bloc.onFetchingData,
        initialData: InitialStates(),
        builder: (context, snapshot) {
          if (!snapshot.hasError) {
            if (snapshot.hasData) {
              if (snapshot.data is LoadingEnrollmentStates) {
                return Scaffold(
                  body: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: AnimatedLoading(
                          title: (snapshot.data! as LoadingEnrollmentStates)
                              .title),
                    ),
                  ),
                );
              }
            }
            if (snapshot.data is InitialStates) {
              return Scaffold(
                  appBar: AppBar(
                    title: const Text("Matricula"),
                  ),
                  body: Center(
                      child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Center(
                              child: Text(
                            "O aluno já possui cadastro?",
                            textAlign: TextAlign.center,
                            style: theme.textTheme.headlineMedium,
                          )),
                          const SizedBox(
                            height: 48,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: widget.bloc.studentCreate,
                                  child: const Center(child: Text("Não")),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: FilledButton(
                                  onPressed: widget.bloc.studentSelection,
                                  child: const Center(child: Text("Sim")),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )));
            }
            if (snapshot.data is SelectStudentEnrollmentStates) {
              final studentModelBloc =
                  (snapshot.data as SelectStudentEnrollmentStates);
              return Scaffold(
                appBar: AppBar(
                  title: const Text("Selecione um aluno"),
                ),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        AppSearch(
                          context,
                          itens: ListStudents(
                            students: studentModelBloc.students,
                            onTapItem: widget.bloc.selectedStudent,
                          ),
                          title: 'pesquisa',
                          search: studentModelBloc.search,
                          secondaryActionIcon: widget.bloc.claenSearch,
                          onChangedSearch: widget.bloc.search,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
            if (snapshot.data is SelectCourseEnrollmentStates) {
              final studentModelBloc =
                  (snapshot.data as SelectCourseEnrollmentStates);
              return Scaffold(
                  appBar: AppBar(
                    title: const Text("Matricula"),
                  ),
                  floatingActionButton: FloatingActionButton.extended(
                      label: const Text("Cadastrar"),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          widget.bloc.register();
                        }
                      }),
                  body: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 8,
                            ),
                            StreamBuilder<StudentModel?>(
                                stream: widget.bloc.studentController,
                                builder: (context, snapshotStudentController) {
                                  return TextFormField(
                                    controller: TextEditingController(
                                        text: snapshotStudentController
                                            .data?.name),
                                    readOnly: true,
                                    // initialValue:
                                    //     snapshotStudentController.data?.name ??
                                    //         "Selecione ou cadastre um aluno",
                                    decoration: const InputDecoration(
                                      labelText: "Aluno",
                                    ),
                                  );
                                }),
                            const SizedBox(height: 16),
                            StreamBuilder<CourseModel?>(
                                stream: widget.bloc.courseController,
                                builder: (context, snapshotCourseController) {
                                  return RepaintBoundary(
                                    child: DropdownButtonFormField<CourseModel>(
                                        validator: (value) {
                                          if (value == null) {
                                            return "Selecione um curso!";
                                          }
                                          return null;
                                        },
                                        decoration: const InputDecoration(
                                          labelText: "Selecione um Curso",
                                        ),
                                        isExpanded: true,
                                        value: snapshotCourseController.data,
                                        onChanged: widget.bloc.changeCuorse,
                                        items: studentModelBloc.courses
                                            .map<DropdownMenuItem<CourseModel>>(
                                                (CourseModel value) {
                                          return DropdownMenuItem<CourseModel>(
                                            value: value,
                                            child: Text(
                                              value.description,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          );
                                        }).toList()),
                                  );
                                })
                          ],
                        ),
                      ),
                    ),
                  ));
            }
            if (snapshot.data is SuccesStates) {
              return Scaffold(
                body: AppSuccesss(
                    context: context,
                    title: (snapshot.data as SuccesStates).successInformation,
                    action: widget.bloc.navigatorPop),
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
                        widget.bloc.navigatorPop();
                        widget.bloc.navigatorPop();
                      },
                    ),
                  ]),
            );
          }

          return Scaffold(
            appBar: AppBar(),
            body: const Center(
              child: Text("Sem dado para exibir"),
            ),
          );
        });
  }
}
