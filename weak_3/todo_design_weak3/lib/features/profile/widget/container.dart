import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_design_weak3/core/utils/app_icon.dart';

class MyContainer extends StatelessWidget {
  final String? text;
  final Widget? icon;
  const MyContainer({super.key, this.icon, this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        height: 63,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  icon!,
                  SizedBox(width: 15),
                  Text(text!, style: TextStyle(fontSize: 16)),
                ],
              ),
              SvgPicture.asset(Appicons.right),
            ],
          ),
        ),
      ),
    );
  }
}
