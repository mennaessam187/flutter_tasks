import 'package:flutter/material.dart';
import 'package:news_app_nti/core/utils/colors.dart';

class MyElevatedButton extends StatelessWidget {
  final void Function()? onPressed;
  final Widget? children;
  const MyElevatedButton({super.key, this.onPressed, required this.children});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.all(AppColor.backgroundColor),
        maximumSize: WidgetStateProperty.all(Size.fromHeight(56)),
        backgroundColor: WidgetStateProperty.all(AppColor.baseFontColor),
      ),
      onPressed: onPressed,
      child: children,
    );
  }
}
