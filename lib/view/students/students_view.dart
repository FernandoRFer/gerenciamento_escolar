import 'dart:developer';

import 'package:escola/components/app_card.dart';
import 'package:escola/components/app_dialog.dart';
import 'package:escola/components/bottom_sheet.dart';
import 'package:escola/components/error_view.dart';
import 'package:escola/components/form.dart';
import 'package:escola/components/icon_animated.dart';
import 'package:escola/components/loading.dart';
import 'package:escola/model/student_model.dart';
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
                    label: const Text("Novo cadastro"), onPressed: () {}),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: TextFormField(
                            controller: studentModelBloc.search.isEmpty
                                ? TextEditingController(text: "")
                                : null,
                            decoration: InputDecoration(
                              label: const Text("pesquisa"),
                              suffixIcon: AppIconAnimated(
                                primaryIcon: Icons.search,
                                secondaryIcon: Icons.close,
                                secondaryActionIcon: () {
                                  widget.bloc.claenSearch();
                                },
                                isSelected: studentModelBloc.search.isEmpty,
                              ),
                            ),
                            onChanged: (value) {
                              widget.bloc.search(value);
                            },
                          ),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: studentModelBloc.students.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              onTap: () => widget.bloc.studentDetails(
                                  studentModelBloc.students[index]),
                              leading: const CircleAvatar(
                                child: Icon(Icons.person_outline),
                              ),
                              title:
                                  Text(studentModelBloc.students[index].nome),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          } else {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              AppBottomSheet.bottomSheetCustom(
                context: context,
                isDismissible: true,
                enableDrag: true,
                child: ErrorView(
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
            });
          }

          return const Center(
            child: Text("Sem cursos para exibir"),
          );
        });
  }
}
