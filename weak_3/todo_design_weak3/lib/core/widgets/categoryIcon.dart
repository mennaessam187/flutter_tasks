import 'package:flutter/material.dart';
import 'package:todo_design_weak3/core/utils/app_color.dart';

class Categoryicon extends StatelessWidget {
  final Widget? child;
  const Categoryicon({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 22,
      height: 22,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: AppColor.baseColor,
      ),
      child: child,
    );
  }
}
