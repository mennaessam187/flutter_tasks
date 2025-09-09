import 'package:flutter/material.dart';
import 'package:news_app_nti/core/utils/colors.dart';

class MyTextFormField extends StatelessWidget {
  final FormFieldValidator<String>? validator;
  final TextEditingController? controller;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Function()? onTap;
  final bool obscureText;
  final bool readonly;
  final Function(String)? onChanged;
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
    this.onChanged
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      validator: validator,
      controller: controller,
      obscureText: obscureText,
      readOnly: readonly,
      onTap: onTap,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColor.formfieldbackground,
        focusColor: AppColor.formfieldbackground,
        hintStyle: TextStyle(
          color: AppColor.blackFontColor,
          fontSize: 14,
          fontWeight: FontWeight.w200,
        ),

        hintText: hintText,

        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: AppColor.formfieldbackground, width: 1),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: AppColor.formfieldbackground, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: AppColor.formfieldbackground, width: 1),
        ),
      ),
    );
  }
}
