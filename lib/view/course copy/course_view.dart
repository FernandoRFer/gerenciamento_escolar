import 'dart:developer';

import 'package:escola/components/app_card.dart';
import 'package:escola/components/app_dialog.dart';
import 'package:escola/components/bottom_sheet.dart';
import 'package:escola/components/error_view.dart';
import 'package:escola/components/form.dart';
import 'package:escola/components/loading.dart';
import 'package:escola/model/course_model.dart';
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
  final List<GlobalKey> keys = [];

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
    final ThemeData theme = Theme.of(context);
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
              final listCourses = (snapshot.data as CourseModelBloc).courses;
              return Scaffold(
                  appBar: AppBar(
                    title: const Text("Cursos"),
                  ),
                  body: SingleChildScrollView(
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: listCourses.length,
                            itemBuilder: (context, index) {
                              keys.add(GlobalKey());
                              return Card(
                                  semanticContainer: true,
                                  key: keys[index],
                                  child: ExpansionTile(
                                    onExpansionChanged: (e) async {
                                      BuildContext? context;
                                      await Future.delayed(
                                          const Duration(milliseconds: 200),
                                          () {
                                        if ((index + 1) == listCourses.length) {
                                          context = keys[0].currentContext;
                                          Scrollable.ensureVisible(
                                            context!,
                                            alignment: -10,
                                            duration: const Duration(
                                                milliseconds: 600),
                                          );
                                        } else if (index != 0) {
                                          context = keys[index].currentContext;
                                          Scrollable.ensureVisible(
                                            context!,
                                            duration: const Duration(
                                                milliseconds: 600),
                                          );
                                        } else if (index == 0) {
                                          context = keys[index].currentContext;
                                          Scrollable.ensureVisible(
                                            context!,
                                            alignment: 10,
                                            duration: const Duration(
                                                milliseconds: 600),
                                          );
                                        }
                                      });
                                    },
                                    title: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          listCourses[index].descricao,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(listCourses[index].ementa)
                                      ],
                                    ),
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: ElevatedButton.icon(
                                                  onPressed: () {
                                                    AppDialog
                                                        .showMyDialogOptions(
                                                            context: context,
                                                            title:
                                                                "O curso \"${listCourses[index].descricao}\" será excluido",
                                                            subtitle:
                                                                "Deseja continuar?",
                                                            actionTrue: () {
                                                              widget.bloc.delete(
                                                                  listCourses[
                                                                      index]);
                                                              widget.bloc
                                                                  .navigatorPop();
                                                            },
                                                            actionFalse: () {
                                                              widget.bloc
                                                                  .navigatorPop();
                                                            });
                                                  },
                                                  icon:
                                                      const Icon(Icons.delete),
                                                  label: const Text("Excluir")),
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            Expanded(
                                              child: FilledButton.icon(
                                                  onPressed: () async {
                                                    //Essa instacia é criada para manimulação atravez de seu ponteiro.
                                                    CourseModel courser =
                                                        listCourses[index];
                                                    await AppDialog.showMDialog(
                                                        context: context,
                                                        title: Row(
                                                          children: [
                                                            const Expanded(
                                                              child: Text(
                                                                  "Atualizar curso",
                                                                  overflow:
                                                                      TextOverflow
                                                                          .clip),
                                                            ),
                                                            IconButton(
                                                                onPressed: widget
                                                                    .bloc
                                                                    .navigatorPop,
                                                                icon: const Icon(
                                                                    Icons
                                                                        .close))
                                                          ],
                                                        ),
                                                        content:
                                                            SingleChildScrollView(
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: [
                                                              const SizedBox(
                                                                height: 8,
                                                              ),
                                                              TextFormField(
                                                                initialValue:
                                                                    courser
                                                                        .descricao,
                                                                onChanged: (value) =>
                                                                    courser.descricao =
                                                                        value,
                                                                decoration:
                                                                    const InputDecoration(
                                                                  labelText:
                                                                      "Descrição",
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                height: 16,
                                                              ),
                                                              TextFormField(
                                                                maxLines: null,
                                                                initialValue:
                                                                    courser
                                                                        .ementa,
                                                                onChanged: (value) =>
                                                                    courser.ementa =
                                                                        value,
                                                                decoration:
                                                                    const InputDecoration(
                                                                  labelText:
                                                                      "Ementa",
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        actions: [
                                                          FilledButton(
                                                            onPressed: () {
                                                              widget.bloc
                                                                  .navigatorPop();
                                                              widget.bloc
                                                                  .update(
                                                                      courser);
                                                            },
                                                            child: const Center(
                                                                child: Text(
                                                                    "Atualizar")),
                                                          )
                                                        ]);

                                                    log("${courser.descricao}     ${courser.ementa}");
                                                  },
                                                  icon:
                                                      const Icon(Icons.update),
                                                  label:
                                                      const Text("Atualizar")),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ));
                            },
                          ))));
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
