import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:todo_design_weak3/core/utils/app_color.dart';

class MyButton extends StatelessWidget {
  final Function()? onPressed;
  final String? text;
  final Color? backgroundColor;
  const MyButton({super.key, this.onPressed, this.text, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,

      style: OutlinedButton.styleFrom(
        side: BorderSide(color: AppColor.baseColor),
        foregroundColor: AppColor.baseColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        backgroundColor: backgroundColor,
        shadowColor: AppColor.baseColor,
        elevation: 10,
        minimumSize: Size(double.infinity, 50),
      ),
      child: Text(
        text!,
        style: TextStyle(
          fontSize: 19.sp,
          color: (backgroundColor == AppColor.baseColor)
              ? AppColor.buttonTextColor
              : AppColor.baseColor,
        ),
      ),
    );
  }
}
/*
ElevatedButton(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(backgroundColor),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
        minimumSize: WidgetStateProperty.all(const Size(331, 48.01)),
      ),
      onPressed: onPressed,
      child: Text(text!, style: const TextStyle(color: Colors.white)),
    );
*/