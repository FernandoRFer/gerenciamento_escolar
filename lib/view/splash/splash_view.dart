import 'package:gerenciamento_escolar/view/splash/splash_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SplashView extends StatefulWidget {
  final ISplashBloc bloc;
  const SplashView(
    this.bloc, {
    super.key,
  });

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  ValueNotifier<bool> isAuth = ValueNotifier(false);
  late AnimationController _animation;

  @override
  void initState() {
    super.initState();

    _animation = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1200));
    widget.bloc.load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Bem vindo,\ncontrole escolar",
                  style: TextStyle(fontFamily: "Chunk", fontSize: 30))
              .animate(onPlay: (controller) => controller.repeat())
              .shimmer(
                  duration: 1200.ms,
                  color: Theme.of(context).primaryColorLight,
                  angle: -0.2)
        ],
      ),
    )));
  }
}
