import 'dart:async';

import 'package:flutter/material.dart';

class AppBottomSheet {
  static Future<bool?> bottomSheetCustom({
    required BuildContext context,
    required Widget child,
    required bool isDismissible,
    bool enableDrag = false,
  }) async {
    return await showModalBottomSheet<bool>(
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      context: context,
      builder: ((context) {
        return SizedBox(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Flexible(
                    flex: 4,
                    child: Container(),
                  ),
                  const Flexible(
                      flex: 2,
                      child: Divider(
                        thickness: 2,
                        color: Colors.grey,
                      )),
                  Flexible(
                    flex: 4,
                    child: Container(),
                  ),
                ],
              ),
              child,
            ],
          ),
        );
      }),
    );
  }
}
