import 'package:flutter/material.dart';
import 'package:todo_design_weak3/core/utils/app_color.dart';

class MyTextFormField extends StatelessWidget {
  final FormFieldValidator<String>? validator;
  final TextEditingController? controller;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Function()? onTap;
  final bool obscureText;
  final bool readonly;
  const MyTextFormField({
    super.key,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.onTap,
    this.obscureText = false,
    this.controller,
    this.readonly = false,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      obscureText: obscureText,
      readOnly: readonly,
      onTap: onTap,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColor.buttonTextColor,
        focusColor: AppColor.buttonTextColor,
        hintStyle: TextStyle(
          color: AppColor.greyTextColor,
          fontSize: 14,
          fontWeight: FontWeight.w200,
        ),

        hintText: hintText,

        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: AppColor.buttonTextColor, width: 1),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: AppColor.buttonTextColor, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: AppColor.buttonTextColor, width: 1),
        ),
      ),
    );
  }
}
