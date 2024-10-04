import 'package:gerenciamento_escolar/components/error_view.dart';
import 'package:gerenciamento_escolar/components/loading.dart';
import 'package:gerenciamento_escolar/components/success.dart';
import 'package:gerenciamento_escolar/model/course_model.dart';
import 'package:gerenciamento_escolar/view/course_details/components/course_detalis_widget.dart';
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
    return StreamBuilder<CourseDetailsStates>(
        stream: widget.bloc.onFetchingData,
        initialData: LoadingCourseDetailsStates(),
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

              if (snapshot.data is CourseDetailsModelBloc) {
                final courseDetails = snapshot.data as CourseDetailsModelBloc;
                return CourseDetalisWidget(
                  courseDetails: courseDetails,
                  bloc: widget.bloc,
                );
              }

              if (snapshot.data is DeletedCoursetStates) {
                return Scaffold(
                  body: AppSuccesss(
                      context: context,
                      title: "Curso excluido com sucesso!",
                      action: widget.bloc.navigatorPop),
                );
              }
              if (snapshot.data is UpdatesCoursetStates) {
                return Scaffold(
                  body: AppSuccesss(
                      context: context,
                      title: (snapshot.data as UpdatesCoursetStates)
                          .updateInformation,
                      action: widget.bloc.recharge),
                );
              }
            }
          }

          return const Scaffold(
              body: Center(child: Text("Sem dados para exibir")));
        });
  }
}
