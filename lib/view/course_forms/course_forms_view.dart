import 'package:gerenciamento_escolar/components/error_view.dart';
import 'package:gerenciamento_escolar/components/loading.dart';
import 'package:gerenciamento_escolar/components/success.dart';
import 'package:gerenciamento_escolar/core/utils/validator.dart';
import 'package:gerenciamento_escolar/model/course_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'course_forms_bloc.dart';

class CourseFormsViewArguments {
  CourseModel course;
  CourseFormsViewArguments({required this.course});
}

class CourseFormsView extends StatefulWidget {
  final ICourseCreateBloc bloc;
  const CourseFormsView(
    this.bloc, {
    super.key,
  });

  @override
  State<CourseFormsView> createState() => _CourseFormsViewState();
}

class _CourseFormsViewState extends State<CourseFormsView> with Validator {
  final _formKey = GlobalKey<FormState>();
  CourseModel? courseDetails;
  String titleAppBar = "Cadastro de curso";
  ActionCourseForms actionForms = ActionCourseForms.create;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      final args = ModalRoute.of(context)!.settings.arguments
          as CourseFormsViewArguments?;

      widget.bloc.load(args?.course);
    });
  }

  @override
  void dispose() {
    super.dispose();
    widget.bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<CourseFormsStates>(
        stream: widget.bloc.onFetchingData,
        initialData: LoadingCourseFormsStates(),
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
              if (snapshot.data is LoadingCourseFormsStates) {
                return const Scaffold(
                  body: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                      child: AnimatedLoading(),
                    ),
                  ),
                );
              }

              if (snapshot.data is CourseUpdateModelStates ||
                  snapshot.data is CourseCreateStates) {
                if (snapshot.data is CourseUpdateModelStates) {
                  titleAppBar = "Editar de curso";
                  actionForms = ActionCourseForms.update;
                  courseDetails =
                      (snapshot.data as CourseUpdateModelStates).course;
                }

                return Scaffold(
                    appBar: AppBar(
                      title: Text(titleAppBar),
                    ),
                    floatingActionButtonLocation:
                        FloatingActionButtonLocation.centerFloat,
                    floatingActionButton: FloatingActionButton.extended(
                        label: const Text("Concluir!"),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            widget.bloc.action(actionForms);
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
                                initialValue: courseDetails?.description,
                                onChanged: widget.bloc.changeDescription,
                                decoration: const InputDecoration(
                                  labelText: "Descrição",
                                ),
                              ),
                              const SizedBox(height: 8),
                              TextFormField(
                                maxLines: 4,
                                maxLength: 500,
                                validator: mediumTextValidator,
                                initialValue: courseDetails?.syllabus,
                                onChanged: widget.bloc.changeSyllabus,
                                decoration: const InputDecoration(
                                  labelText: "Ementa",
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
                      action: widget.bloc.navigatorPop),
                );
              }
            }
          }

          return const Scaffold(
              body: Center(child: Text("Sem dados para exibir")));
        });
  }
}
