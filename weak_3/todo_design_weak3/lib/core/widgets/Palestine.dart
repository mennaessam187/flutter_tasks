import 'package:flutter/material.dart';
import 'package:todo_design_weak3/core/utils/app_image.dart';

class PalestineImage extends StatelessWidget {
  const PalestineImage({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadiusGeometry.only(
        bottomLeft: Radius.circular(20),
        bottomRight: Radius.circular(20),
      ),
      child: Image.asset(Appimage.phalistineImage, width: 375),
    );
  }
}
