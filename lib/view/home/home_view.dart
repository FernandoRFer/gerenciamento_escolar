import 'package:escola/components/bottom_sheet.dart';
import 'package:escola/components/error_view.dart';
import 'package:escola/components/loading.dart';
import 'package:escola/view/home/components/body_home.dart';
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

            return BodyHome(
              bloc: widget.bloc,
            );
          }),
    );
  }
}
