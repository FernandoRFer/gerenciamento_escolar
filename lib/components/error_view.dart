import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<Widget>? buttons;
  final bool enableDrag = false;

  const ErrorView({
    super.key,
    this.title = "",
    this.subtitle = "",
    this.buttons,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: [
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(title,
                    style: const TextStyle(
                      color: Colors.red,
                    )),
                const SizedBox(height: 16),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 250),
                  child: SingleChildScrollView(
                    child: Text(subtitle, style: const TextStyle()),
                  ),
                ),
                const SizedBox(height: 55),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [...buttons ?? []],
            ),
          ),
        ],
      ),
    );
  }
}
