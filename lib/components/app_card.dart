import 'package:flutter/material.dart';

class CCard extends StatelessWidget {
  const CCard({super.key, this.padding, this.color, this.child});
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Card(
      color: color,
      margin: const EdgeInsets.fromLTRB(8, 0, 8, 8),
      elevation: isDark ? 1 : 0.5,
      child: Padding(
        padding: padding ?? const EdgeInsets.all(12),
        child: child,
      ),
    );
  }
}
