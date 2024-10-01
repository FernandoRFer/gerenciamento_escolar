import 'package:flutter/material.dart';

class AppDialog {
  static Future<void> showMDialog({
    required BuildContext context,
    Widget? title,
    Widget? content,
    List<Widget>? actions,
  }) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: const EdgeInsets.all(16),
          contentPadding: const EdgeInsets.symmetric(horizontal: 8),
          titlePadding: const EdgeInsets.all(8),
          actionsPadding: const EdgeInsets.all(8),
          title: title,
          content: content,
          actions: actions,
        );
      },
    );
  }

  static Future<void> showMyDialogOptions({
    required BuildContext context,
    String title = "Deseja continuar?",
    String subtitle = "",
    Function()? actionTrue,
    Function()? actionFalse,
  }) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: const EdgeInsets.all(16),
          contentPadding: const EdgeInsets.symmetric(horizontal: 8),
          titlePadding: const EdgeInsets.all(8),
          actionsPadding: const EdgeInsets.all(8),
          title: Text(
            title,
            textAlign: TextAlign.center,
          ),
          content: Text(
            subtitle,
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                    child: OutlinedButton(
                  onPressed: actionFalse,
                  child: const Center(child: Text("Não")),
                )),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                    child: FilledButton(
                  onPressed: actionTrue,
                  child: const Center(child: Text("Sim")),
                ))
              ],
            )
          ],
        );
      },
    );
  }

  static Future<void> showDialogInf({
    required BuildContext context,
    String title = "",
    String subtitle = "",
    String titleButton = "Voltar",
    Function()? onPressed,
  }) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: const EdgeInsets.all(16),
          contentPadding: const EdgeInsets.symmetric(horizontal: 8),
          titlePadding: const EdgeInsets.all(8),
          actionsPadding: const EdgeInsets.all(8),
          title: Text(
            title,
            textAlign: TextAlign.center,
          ),
          content: Text(
            subtitle,
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            FilledButton(
              onPressed: onPressed,
              child: Center(child: Text(titleButton)),
            )
          ],
        );
      },
    );
  }
}
