import 'package:flutter/material.dart';
import 'package:todo_design_weak3/core/utils/app_color.dart';

class MyButton1 extends StatelessWidget {
  const MyButton1({super.key});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: AppColor.baseColor),
        foregroundColor: AppColor.baseColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        backgroundColor: Colors.white,
        shadowColor: AppColor.baseColor,
        elevation: 2,
        minimumSize: Size(double.infinity, 50),
      ),
      child: Text(
        'Update',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppColor.buttonTextColor,
        ),
      ),
    );
  }
}
