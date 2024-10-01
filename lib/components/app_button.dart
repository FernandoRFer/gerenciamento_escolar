// ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:flutter/material.dart';

// class AppOutlinedButton extends StatelessWidget {
//   const AppOutlinedButton(this.text,
//       {this.onPressed,
//       super.key,
//       this.colorText,
//       this.reduceSize = false,
//       this.icon});
//   final String text;
//   final Color? colorText;
//   final void Function()? onPressed;
//   final bool reduceSize;
//   final Widget? icon;

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       style: ButtonStyle(
//           backgroundColor: WidgetStateProperty.all(
//               Theme.of(context).bottomSheetTheme.backgroundColor),
//           shape: WidgetStateProperty.all(
//             const RoundedRectangleBorder(
//                 borderRadius: BorderRadius.all(
//               Radius.circular(16),
//             )),
//           )),
//       onPressed: onPressed,
//       child: Container(
//         child: icon == null
//             ? Padding(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 24, vertical: 8.0),
//                 child: Center(
//                   child: Text(text,
//                       style: TextStyle(
//                           color: colorText, fontWeight: FontWeight.bold)),
//                 ))
//             : Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: SizedBox(height: 30, child: icon!),
//                   ),
//                   const SizedBox(width: 10),
//                   Text(text,
//                       style: TextStyle(
//                           color: colorText, fontWeight: FontWeight.bold)),
//                 ],
//               ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class AppOutlinedButton extends StatelessWidget {
  final Widget child;
  const AppOutlinedButton({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: () {},
        child: const SizedBox(
            height: 75,
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.library_books),
                    SizedBox(
                      width: 8,
                    ),
                    Center(child: Text('Cursos')),
                  ],
                ),
              ),
            )));
  }
}
