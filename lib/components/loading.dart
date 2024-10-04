import 'package:flutter/material.dart';
import 'dots_loading.dart';

class AnimatedLoading extends StatelessWidget {
  final String title;
  const AnimatedLoading({
    super.key,
    this.title = "Carregando",
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 40,
          ),
          const SizedBox(
            width: 350,
            child: LinearProgressIndicator(
              minHeight: 10,
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          title != null
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.headlineSmall,
                      textAlign: TextAlign.justify,
                    ),
                    const DotsLoading(),
                  ],
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
