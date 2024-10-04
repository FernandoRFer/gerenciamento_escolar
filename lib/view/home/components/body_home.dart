import 'package:escola/view/home/home_bloc.dart';
import 'package:flutter/material.dart';

class BodyHome extends StatelessWidget {
  final IHomeBloc bloc;
  const BodyHome({
    super.key,
    required this.bloc,
  });

  Widget _appOutlinedButton(
      String title, IconData icon, Function()? onPressed) {
    return OutlinedButton(
        onPressed: onPressed,
        child: SizedBox(
            height: 75,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(icon, size: 30),
                    const SizedBox(width: 8),
                    Text(title,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18)),
                  ],
                ),
              ),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(children: [
          _appOutlinedButton(
              'Cursos', Icons.library_books, bloc.navigatorCourse),
          const SizedBox(height: 8),
          _appOutlinedButton('Alunos', Icons.supervised_user_circle_outlined,
              bloc.navigatorStudents),
          const SizedBox(height: 8),
          _appOutlinedButton('Matriculas', Icons.library_add_outlined,
              bloc.navigatorEnrollment),
        ]),
      ),
    );
  }
}
