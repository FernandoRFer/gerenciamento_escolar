import 'package:gerenciamento_escolar/components/error_view.dart';
import 'package:gerenciamento_escolar/components/loading.dart';
import 'package:gerenciamento_escolar/view/home/components/body_home.dart';
import 'package:flutter/material.dart';
import 'home_bloc.dart';

class HomeView extends StatefulWidget {
  final IHomeBloc bloc;
  const HomeView(
    this.bloc, {
    super.key,
  });

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _userController = TextEditingController();

  @override
  void initState() {
    super.initState();
    widget.bloc.load();
  }

  @override
  void dispose() {
    super.dispose();
    widget.bloc.dispose();
    _userController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: StreamBuilder<HomeModelBloc>(
          stream: widget.bloc.onFetchingData,
          initialData: HomeModelBloc(),
          builder: (context, snapshot) {
            if (!snapshot.hasError) {
              if (snapshot.hasData) {
                if (false) {
                  return const Center(
                    child: AnimatedLoading(),
                  );
                }
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

            return BodyHome(
              bloc: widget.bloc,
            );
          }),
    );
  }
}
