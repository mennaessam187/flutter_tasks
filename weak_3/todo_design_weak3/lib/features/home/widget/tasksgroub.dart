import 'package:flutter/material.dart';

class Tasksgroub extends StatelessWidget {
  final Widget? child;
  const Tasksgroub({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 335,
        height: 63,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(padding: const EdgeInsets.all(8.0), child: child),
      ),
    );
  }
}
