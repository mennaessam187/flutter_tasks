import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_design_weak3/core/utils/app_image.dart';
import 'package:todo_design_weak3/core/utils/textStyle.dart';

class Notasks extends StatelessWidget {
  const Notasks({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 50),
        Column(
          children: [
            Text("There are no tasks yet,", style: textStyle()),
            Text("Press the button", style: textStyle()),
            Text("To add New Task", style: textStyle()),
          ],
        ),
        SizedBox(height: 50),
        SvgPicture.asset(Appimage.homeImage, width: 375, height: 268),
      ],
    );
  }
}
