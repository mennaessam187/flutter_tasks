import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:news_app_nti/core/utils/colors.dart';

class Columnwe extends StatelessWidget {
  final String image;
  final String title;
  final String titlevalue;
  const Columnwe({
    super.key,
    required this.title,
    required this.image,
    required this.titlevalue,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(image),
        SizedBox(width: 10),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              titlevalue,
              style: TextStyle(
                color: AppColor.baseFontColor,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                color: AppColor.wt,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
