import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  AppButton({
    required this.onPressed,
    this.child,
    Color? color,
  }) : color = color ?? Colors.grey[300];

  final VoidCallback onPressed;
  final Widget? child;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      child: child,
      splashColor: Colors.transparent,
      elevation: 0,
      hoverElevation: 0,
      highlightElevation: 0,
      color: color,
    );
  }
}
