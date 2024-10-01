// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class AppIconAnimated extends StatefulWidget {
  final bool isSelected;
  final Function()? primaryActionIcon;
  final Function()? secondaryActionIcon;
  final IconData primaryIcon;
  final IconData secondaryIcon;
  const AppIconAnimated({
    super.key,
    required this.isSelected,
    this.primaryActionIcon,
    this.secondaryActionIcon,
    required this.primaryIcon,
    required this.secondaryIcon,
  });

  @override
  State<AppIconAnimated> createState() => _AppIconAnimatedState();
}

class _AppIconAnimatedState extends State<AppIconAnimated>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: widget.isSelected
          ? widget.primaryActionIcon
          : widget.secondaryActionIcon,
      icon: AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return ScaleTransition(
            scale: animation,
            child: child,
          );
        },
        child: widget.isSelected
            ? Icon(widget.primaryIcon, key: const ValueKey('iconA'))
            : Icon(widget.secondaryIcon, key: const ValueKey('iconB')),
      ),
    );
  }
}
