import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_design_weak3/core/utils/app_color.dart';

Message(context, String title, String desc) {
  AwesomeDialog(
    context: context,
    dialogType: DialogType.error,
    borderSide: BorderSide(color: AppColor.baseColor, width: 2),
    width: 350.h,
    buttonsBorderRadius: const BorderRadius.all(Radius.circular(2)),
    dismissOnTouchOutside: true,
    dismissOnBackKeyPress: false,
    onDismissCallback: (type) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Dismissed by $type')));
    },
    headerAnimationLoop: false,
    animType: AnimType.bottomSlide,
    title: title,
    desc: desc,
    showCloseIcon: true,
    btnCancelOnPress: () {},
    btnOkOnPress: () {},
  ).show();
}
