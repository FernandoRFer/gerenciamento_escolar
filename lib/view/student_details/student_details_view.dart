import 'package:gerenciamento_escolar/components/error_view.dart';
import 'package:gerenciamento_escolar/components/success.dart';
import 'package:gerenciamento_escolar/components/loading.dart';
import 'package:gerenciamento_escolar/model/student_model.dart';
import 'package:gerenciamento_escolar/view/student_details/components/student_details_widget.dart';
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
    return StreamBuilder<StudentDetailsStates>(
        stream: widget.bloc.onFetchingData,
        initialData: LoadingStudentDetailsStates(),
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
                        widget.bloc.navigatorPop();
                      },
                    ),
                  ]),
            );
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
              return StudentDetailsWidget(
                studentDetails: studentDetails,
                bloc: widget.bloc,
              );
            }
            if (snapshot.data is DeletedStudentStates) {
              return Scaffold(
                body: AppSuccesss(
                    context: context,
                    title: "Aluno excluido com sucesso!",
                    action: widget.bloc.navigatorPop),
              );
            }

            if (snapshot.data is UpdateSuccesStudentStates) {
              return Scaffold(
                body: AppSuccesss(
                    context: context,
                    title: (snapshot.data as UpdateSuccesStudentStates).title,
                    action: widget.bloc.recharge),
              );
            }
          }

          return Scaffold(
              appBar: AppBar(),
              body: const Center(child: Text("Sem dados para exibir")));
        });
  }
}
