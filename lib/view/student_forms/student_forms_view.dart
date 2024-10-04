import 'package:gerenciamento_escolar/components/error_view.dart';
import 'package:gerenciamento_escolar/components/loading.dart';
import 'package:gerenciamento_escolar/components/success.dart';
import 'package:gerenciamento_escolar/core/utils/validator.dart';
import 'package:gerenciamento_escolar/model/student_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'student_forms_bloc.dart';

class StudentFormsViewArguments {
  StudentModel studend;
  StudentFormsViewArguments({required this.studend});
}

class StudentFormsView extends StatefulWidget {
  final IStudentFormBloc bloc;
  const StudentFormsView(
    this.bloc, {
    super.key,
  });

  @override
  State<StudentFormsView> createState() => _StudentFormsViewState();
}

class _StudentFormsViewState extends State<StudentFormsView> with Validator {
  final _formKey = GlobalKey<FormState>();
  StudentModel? studentDetails;
  String titleAppBar = "Cadastro de aluno";
  ActionStudentForms actionForms = ActionStudentForms.create;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      final args = ModalRoute.of(context)!.settings.arguments
          as StudentFormsViewArguments?;

      widget.bloc.load(args?.studend);
    });
  }

  @override
  void dispose() {
    super.dispose();
    widget.bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<StudentFormsStates>(
        stream: widget.bloc.onFetchingData,
        initialData: LoadingStudentFormsStates(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              body: ErrorView(
                  title: "Error",
                  subtitle: snapshot.error.toString(),
                  buttons: [
                    OutlinedButton(
                      child: const Center(child: Text("Voltar")),
                      onPressed: () {
                        widget.bloc.navigatorPop();
                      },
                    ),
                  ]),
            );
          } else {
            if (snapshot.hasData) {
              if (snapshot.data is LoadingStudentFormsStates) {
                return const Scaffold(
                  body: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                      child: AnimatedLoading(),
                    ),
                  ),
                );
              }

              if (snapshot.data is StudentUpdateModelStates ||
                  snapshot.data is StudentCreateStates) {
                if (snapshot.data is StudentUpdateModelStates) {
                  titleAppBar = "Atualização de curso";
                  actionForms = ActionStudentForms.update;
                  studentDetails =
                      (snapshot.data as StudentUpdateModelStates).student;
                }

                return Scaffold(
                    appBar: AppBar(
                      title: Text(titleAppBar),
                    ),
                    floatingActionButtonLocation:
                        FloatingActionButtonLocation.centerFloat,
                    floatingActionButton: FloatingActionButton.extended(
                        label: const Text("Concluir"),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            widget.bloc.selectAction(actionForms);
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
                              TextFormField(
                                maxLines: 1,
                                maxLength: 50,
                                validator: descripitonValidator,
                                initialValue: studentDetails?.name,
                                onChanged: widget.bloc.changeName,
                                decoration: const InputDecoration(
                                  labelText: "Nome",
                                ),
                              ),
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
                      action: widget.bloc.navigatorPopArgument),
                );
              }
            }
          }

          return const Scaffold(
              body: Center(child: Text("Sem dados para exibir")));
        });
  }
}
