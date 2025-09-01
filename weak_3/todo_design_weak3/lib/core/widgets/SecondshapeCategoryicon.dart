import 'package:flutter/material.dart';

class Secondshapecategoryicon extends StatelessWidget {
  final Widget? child;
  final Color? color;
  const Secondshapecategoryicon({super.key, this.child, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 35,
      height: 35,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: color,
      ),
      child: child,
    );
  }
}
