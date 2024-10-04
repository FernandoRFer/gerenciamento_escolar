import 'package:escola/components/error_view.dart';
import 'package:escola/components/loading.dart';
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

class _EnrollmentViewState extends State<EnrollmentView> {
  final List<GlobalKey> keys = [];
  bool isSelected = true;

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
    return StreamBuilder<EnrollmentStates>(
        stream: widget.bloc.onFetchingData,
        initialData: EnrollmentModelBloc(),
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
            if (snapshot.data is EnrollmentModelBloc) {
              final studentModelBloc = (snapshot.data as EnrollmentModelBloc);
              return Container();
            }
          } else {
            return ErrorView(
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
                ]);
          }

          return const Center(
            child: Text("Sem cursos para exibir"),
          );
        });
  }
}
