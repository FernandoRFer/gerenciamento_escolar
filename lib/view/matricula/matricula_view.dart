import 'package:flutter/material.dart';

class MatriculaView extends StatefulWidget {
  const MatriculaView({super.key});

  @override
  State<MatriculaView> createState() => _MatriculaViewState();
}

class _MatriculaViewState extends State<MatriculaView> {
  final _tabs = [
    const Tab(text: 'Tab1'),
    const Tab(text: 'Tab2'),
    const Tab(text: 'Tab3'),
  ];

  static const _selectedColor = Color(0xff1a73e8);
  static const _unselectedColor = Color(0xff5f6368);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: _tabs,
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Container(
                  color: (Colors.black),
                )
              ],
            )),
      ),
    );
  }
}
