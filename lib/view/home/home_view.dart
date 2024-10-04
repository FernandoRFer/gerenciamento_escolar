import 'package:gerenciamento_escolar/components/error_view.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: StreamBuilder<HomeStatesBloc>(
          stream: widget.bloc.onFetchingData,
          initialData: HomeStatesBloc(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
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

            return BodyHome(bloc: widget.bloc);
          }),
    );
  }
}
